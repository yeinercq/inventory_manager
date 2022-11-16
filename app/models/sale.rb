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

  belongs_to :user
  belongs_to :client, class_name: 'Customer'

  has_many :items, dependent: :destroy
  has_many :products, through: :items

  delegate :company, to: :user

  before_create :generate_code

  scope :ordered,-> { order(id: :desc) }
  scope :filter_by_status, ->(status) { where("status = ?", status) }
  scope :filter_by_client, ->(client) { where("client = ?", client) }
  scope :filter_by_code, ->(code) { where("code = ?", code) }

  def total_price
    items.sum(&:total_price)
  end

  aasm column: :status do
    state :recorded, initial: true
    state :confirmed, :paid, :delivered

    after_all_transitions :log_status_change

    event :confirm do
      transitions from: :recorded, to: :confirmed
    end

    event :pay do
      transitions from: :confirmed, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
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
