# == Schema Information
#
# Table name: coffee_purchases
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  client_id               :bigint           not null
#  quantity                :decimal(10, 2)
#  coffee_type             :integer
#  base_purchase_price     :decimal(10, 2)
#  packs_count             :integer
#  sample_quantity         :decimal(5, 2)
#  decrease_quantity       :decimal(5, 2)
#  sieve_quantity          :decimal(5, 2)
#  healthy_almond_quantity :decimal(5, 2)
#  pasilla_quantity        :decimal(5, 2)
#  factor_rate             :decimal(5, 2)
#  purchase_price          :decimal(10, 2)
#  code                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  destare_quantity        :decimal(5, 2)
#  status                  :string
#  transitions             :hstore           is an Array
#
class CoffeePurchase < ApplicationRecord
    # { client_id: client.id, quantity: 100, coffee_type: "seco", base_purchase_price: 970000.00, packs_count: 2, sample_quantity: 250.0, decrease_quantity: 202.2, sieve_quantity: 1, healthy_almond_quantity: 195.0, pasilla_quantity: 6 }
  include AASM

  belongs_to :user
  belongs_to :client, class_name: "Customer"
  delegate :company, to: :user

  enum coffee_type: { seco: 1, verde: 2, pasilla: 3 }

  scope :ordered,-> { order(id: :desc) }
  scope :valid_countable, -> { where('status != ? AND status != ?', 'guardada', 'confirmada') }
  scope :last_month, -> { filter_by_date((Date.current - 1.months).beginning_of_month.beginning_of_day, (Date.current - 1.months).end_of_month.end_of_day) }
  scope :this_month, -> { filter_by_date(Date.current.beginning_of_month.beginning_of_day, Date.current.end_of_month.end_of_day) }
  scope :this_year, -> { filter_by_date(Date.current.beginning_of_year.beginning_of_day, Date.current.end_of_year.end_of_day) }
  scope :filter_by_status, ->(status) { where("status = ?", status) }
  scope :filter_by_code, ->(code) { where("code = ?", code) }
  scope :filter_by_client_id_number, ->(client_id_number) { joins(:client).where("id_number = ?", client_id_number) }
  # scope :filter_by_company_id, -> (company_id) { joins(:user).joins(:company).where('company_id = ?', company_id) }
  scope :filter_by_date, ->(start_date, end_date) { where("coffee_purchases.created_at >= ? AND coffee_purchases.created_at <= ?", start_date, end_date) }
  scope :filter_by_coffee_type, ->(coffee_type) { where("coffee_type = ?", coffee_type) }

  before_validation :set_base_purchase_price, :compute_factor_price, :generate_code
  after_update_commit -> { broadcast_update_to "coffee_wallet_amount", partial: "metrics/coffee_wallet_amount", locals: { coffee_wallet_amount: Wallet.find(company.general_setting.coffee_wallet_id).amount }, target: "coffee_wallet_amount" }


  validates :client_id,
    :quantity,
    :coffee_type,
    # :base_purchase_price,
    :packs_count,
    # :sample_quantity,
    :decrease_quantity,
    :sieve_quantity,
    :healthy_almond_quantity,
    :pasilla_quantity,
    presence: true

  validates :quantity,
    :packs_count,
    :decrease_quantity,
    :sieve_quantity,
    :healthy_almond_quantity,
    :pasilla_quantity,
    numericality: { greater_than: 0 }

  validates_with CoffeePurchases::GreaterThanWalletAmount

  broadcasts_to ->(coffee_purchase) { [coffee_purchase.user.company, "coffee_purchases"] }, inserts_by: :prepend

  def total_price
    ( quantity - ( packs_count * ( destare_quantity / 1000 ) ) ) * purchase_price
  end

  def self.available_states
    aasm.states.map(&:name)
  end

  aasm column: :status do
    state :guardada, initial: true
    state :confirmada, :pagada

    after_all_transitions :log_status_change

    event :confirmar do
      transitions from: :guardada, to: :confirmada
    end

    event :pagar, after: :generate_wallet_withdraw do
      transitions from: :confirmada, to: :pagada
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

  def generate_wallet_withdraw
    CoffeePurchases::GenerateWalletWithdraw.new.call(self)
  end

  def generate_code
    CoffeePurchases::GenerateCode.new.call(self)
  end

  def factor
    17500 / healthy_almond_quantity
  end

  def set_base_purchase_price
    case coffee_type
    when "seco"
      self.base_purchase_price = user.company.general_setting.base_seco_coffee_price
    when "verde"
      self.base_purchase_price = user.company.general_setting.base_verde_coffee_price
    when "pasilla"
      self.base_purchase_price = user.company.general_setting.base_pasilla_coffee_price
    end
  end

  def compute_factor_price
    self.factor_rate = factor
    case coffee_type
    when "seco"
      self.purchase_price = ( ( base_purchase_price / 125 ) * 94 / factor ).floor(-2)
    when "verde"
      self.purchase_price = ( ( base_purchase_price / 125 ) * 93 / factor ).floor(-2)
    when "pasilla"
      self.purchase_price = ( ( base_purchase_price / 125 ) * 94 / factor ).floor(-2)
    end
  end

end
