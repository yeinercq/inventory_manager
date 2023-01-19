# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  code       :string
#  name       :string           not null
#
class Wallet < ApplicationRecord
  belongs_to :company

  has_many :transactions

  validates :amount, :name, presence: true
  # validates :amount, numericality: { greater_than: 0 }

  after_create :generate_code

  def current_amount
    amount
  end

  def new_amount(transaction_type, amount)
    new_amount = 0
    case transaction_type
    when "deposit"
      new_amount = current_amount + amount
    when "withdraw"
      new_amount = current_amount - amount
    when "transfer"
      new_amount = current_amount - amount
    end
    new_amount
  end

  private

  def generate_code
    Wallets::GenerateCode.new.call(self)
    self.save
  end
end
