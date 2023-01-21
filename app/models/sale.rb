# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string
#  client_id   :bigint           not null
#  status      :string
#  transitions :hstore           is an Array
#
class Sale < ApplicationRecord
  include AASM
  include Sales::TotalPerDateRange

  belongs_to :user
  belongs_to :client, class_name: 'Customer'

  has_many :items, dependent: :destroy
  has_many :products, through: :items

  delegate :company, to: :user

  before_create :generate_code

  scope :ordered,-> { order(id: :desc) }
  scope :valid_countable, -> { where('status != ? AND status != ?', 'guardada', 'confirmada') }
  scope :last_month, -> { filter_by_date((Date.current - 1.months).beginning_of_month.beginning_of_day, (Date.current - 1.months).end_of_month.end_of_day) }
  scope :this_month, -> { filter_by_date(Date.current.beginning_of_month.beginning_of_day, Date.current.end_of_month.end_of_day) }
  scope :this_year, -> { filter_by_date(Date.current.beginning_of_year.beginning_of_day, Date.current.end_of_year.end_of_day) }
  scope :filter_by_status, ->(status) { where("status = ?", status) }
  scope :filter_by_code, ->(code) { where("code = ?", code) }
  scope :filter_by_client_id_number, ->(client_id_number) { joins(:client).where("id_number = ?", client_id_number) }
  scope :filter_by_company_id, -> (company_id) { joins(:user).joins(:company).where('company_id = ?', company_id) }
  scope :filter_by_date, ->(start_date, end_date) { where("sales.created_at >= ? AND sales.created_at <= ?", start_date, end_date) }

  broadcasts_to ->(sale) { [sale.company, "sales"] }, inserts_by: :prepend

  def total_price
    items.sum(&:total_price)
  end

  def total_earning
    earning = []
    items.each { |i| earning << i.movement.earning_amount }
    earning.sum
  end

  def self.total_sales
    all.sum(&:total_price)
  end

  def self.available_states
    aasm.states.map(&:name)
  end

  aasm column: :status do
    state :guardada, initial: true
    state :confirmada, :pagada, :entregada

    after_all_transitions :log_status_change
    # after :pagar, :generate_wallet_transaction

    event :confirmar do
      transitions from: :guardada, to: :confirmada
    end

    event :pagar, after: :generate_wallet_deposit do
      transitions from: :confirmada, to: :pagada
    end

    event :entregar do
      transitions from: :pagada, to: :entregada
    end
  end

  def log_status_change
    transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end

  private

  def generate_wallet_deposit
    user.transactions.create(
      transaction_type: "deposit",
      amount: total_price,
      wallet_id: company.general_setting.sales_wallet_id,
      options: { "sale_id" => id }
    )
  end

  def generate_code
    Sales::GenerateCode.new.call(self)
  end
end
