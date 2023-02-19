class Sales::GenerateWalletDeposit
  def call(sale)
    sale.user.transactions.create(
      transaction_type: "deposit",
      amount: sale.total_price,
      wallet_id: sale.location.wallet.id,
      options: { "sale_id" => sale.id }
    )
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
