class Reports::CsvReportGeneratorService
  require 'csv'

  def initialize(export:)
    @export = export
  end

  def generate
    write_to_csv_file
    upload_report_to_s3
    update_export_path
    [true, 'successful']
  rescue => e
    Rails.logger.error e
    [false, 'failed']
  end

  private

  attr_accessor :export, :path, :csv

  def write_to_csv_file
    @csv = CSV.generate do |csv|
      report_generator_class = CsvReportFactory.for(export.key).new(csv, export.data_filters)
      report_generator_class.generate_report
    end
  end

  def upload_report_to_s3
    # returns path to the file on S3 bucket
    s3_uploader = Reports::S3Uploader.new(csv)
    @path = s3_uploader.upload_file_to_s3
  end

  def update_export_path
    export.update(status: :finished, file_path: path)
  end
end
