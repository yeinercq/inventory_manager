# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_type :integer
#  amount           :decimal(10, 2)
#  wallet_id        :bigint           not null
#  user_id          :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :user

  enum transaction_type: { deposit: 1, withdraw: 2, transfer: 3 }

  validates :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates_with Transactions::GreaterThanWalletAmount, if: :is_output_transaction

  after_create :update_wallet

  def update_wallet
    new_amount = 0
    case transaction_type
    when "deposit"
      new_amount = wallet.current_amount + amount
    when "withdraw"
      new_amount = wallet.current_amount - amount
    when "transfer"
      new_amount = wallet.current_amount - amount
    end
    wallet.update(amount: new_amount)
  end

  def is_output_transaction
    transaction_type == "withdraw" or transaction_type == "transfer"
  end
end
