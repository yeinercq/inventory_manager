AMAZON_S3_CLIENT = Aws::S3::Client.new(
  region: 'sa-east-1',
  # bucket: Rails.application.credentials.dig(:aws, :bucket),
  access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
)
