class CoffeePurchases::GreaterThanWalletAmount < ActiveModel::Validator
  def validate(record)
    if Wallet.find(record.company.general_setting.coffee_wallet_id).amount < record.total_price
      record.errors.add :base, "The wallet amount is not enough"
    end
  end
end
