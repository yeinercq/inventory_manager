class CoffeePurchases::GenerateCode
  def call(coffee_purchase)
    coffee_purchase.code = "FCC#{Time.now.strftime('%d%m%Y')}#{coffee_purchase.client.id}#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
