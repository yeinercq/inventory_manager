class Reports::S3Uploader
  require 'csv'
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def upload_file_to_s3
    bucket = Rails.application.credentials.dig(:aws, :bucket)
    file_full_path = "reports/csv/#{Time.now.strftime('%d%m%YT%H%M')}#{SecureRandom.hex(8)}.csv"
    # binding.pry
    obj = AMAZON_S3_RESOURCE.bucket(bucket).object(file_full_path)
    obj.put(
      body: file,
      acl: 'public-read',
      content_disposition: 'attachment'
    )
    return file_full_path
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
  end
end
