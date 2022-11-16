class Sales::TriggerEvent
  def call(sale, event)
    sale.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
