class Wallets::GenerateCode
  require 'base64'

  def call(wallet)
    wallet.code = Base64.encode64("#{wallet.company_id}-#{wallet.id}")
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
