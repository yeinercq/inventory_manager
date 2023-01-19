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
#  options          :hstore
#
class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :user

  enum transaction_type: { deposit: 1, withdraw: 2, transfer: 3 }

  validates :transaction_type, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates_with Transactions::GreaterThanWalletAmount, if: :is_output_transaction
  validates_with Transactions::MatchIds, if: :is_transfer_transaction # TODO: see error when amount is nil
  # TODO: see options validation when is blank
  after_create :update_wallet

  def update_wallet
    wallet.update(
      amount: wallet.new_amount(transaction_type, amount)
    )
    generate_transfer if is_transfer_transaction
  end

  private

  def generate_transfer
    target_wallet = Wallet.find(options["target_wallet"].to_i)
    target_wallet.transactions.create(
      transaction_type: "deposit",
      amount: amount,
      wallet_id: target_wallet.id,
      user_id: user_id,
      options: {"from_wallet" => wallet.id}
    )
  end

  def is_transfer_transaction
    transaction_type == "transfer"
  end

  def is_output_transaction
    transaction_type == "withdraw" or transaction_type == "transfer"
  end
end
