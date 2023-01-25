class CoffeePurchases::GenerateWalletWithdraw
  def call(coffee_purchase)
    coffee_purchase.user.transactions.create(
      transaction_type: "withdraw",
      amount: coffee_purchase.total_price,
      wallet_id: coffee_purchase.company.general_setting.coffee_wallet_id.to_i,
      options: {"coffee_purchase" => coffee_purchase.id}
    )
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
