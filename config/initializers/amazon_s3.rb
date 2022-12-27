AMAZON_S3_RESOURCE = Aws::S3::Resource.new(
  region: 'sa-east-1',
  access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
)

AMAZON_S3_CLIENT = Aws::S3::Client.new(
  region: 'sa-east-1',
  access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
)
