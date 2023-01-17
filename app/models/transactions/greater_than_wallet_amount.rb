class Transactions::GreaterThanWalletAmount < ActiveModel::Validator
  def validate(record)
    if record.wallet.current_amount < record.amount
      record.errors.add :base, "The wallet amount is not enough"
    end
  end
end
