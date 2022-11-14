class Sales::GenerateCode
  def call(sale)
    sale.code = "FVF#{Time.now.strftime('%d%m%Y')}#{sale.client.id}#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
