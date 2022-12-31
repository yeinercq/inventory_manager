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
  # include Filterable

  belongs_to :user
  belongs_to :client, class_name: 'Customer'

  has_many :items, dependent: :destroy
  has_many :products, through: :items

  delegate :company, to: :user

  before_create :generate_code

  scope :ordered,-> { order(id: :desc) }
  scope :filter_by_status, ->(status) { where("status = ?", status) }
  scope :filter_by_code, ->(code) { where("code = ?", code) }
  scope :filter_by_client_id_number, ->(client_id_number) { joins(:client).where("id_number = ?", client_id_number) }
  scope :filter_by_date, ->(start_date, end_date) { where("sales.created_at >= ? AND sales.created_at <= ?", start_date, end_date) }
  scope :filter_by_company_id, -> (company_id) { joins(:user).joins(:company).where('company_id = ?', company_id) }

  broadcasts_to ->(sale) { [sale.company, "sales"] }, inserts_by: :prepend

  def total_price
    items.sum(&:total_price)
  end

  aasm column: :status do
    state :guardada, initial: true
    state :confirmada, :pagada, :entregada

    after_all_transitions :log_status_change

    event :confirmar do
      transitions from: :guardada, to: :confirmada
    end

    event :pagar do
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

  def self.available_states
    aasm.states.map(&:name)
  end

  def generate_code
    Sales::GenerateCode.new.call(self)
  end
end
