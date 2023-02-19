class CoffeePurchases::GreaterThanWalletAmount < ActiveModel::Validator
  def validate(record)
    if record.location.wallet.amount < record.total_price
      record.errors.add :base, "The wallet amount is not enough"
    end
  end
end
