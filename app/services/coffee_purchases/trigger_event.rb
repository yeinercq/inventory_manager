class CoffeePurchases::TriggerEvent
  def call(coffee_purchase, event)
    coffee_purchase.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
