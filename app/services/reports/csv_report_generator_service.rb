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
    # binding.pry
  rescue => e
    Rails.logger.error e
    # binding.pry
    [false, 'failed']
  end

  private

  attr_accessor :export

  def write_to_csv_file
    CSV.generate do |csv|
      report_generator_class = CsvReportFactory.for(export.key).new(csv)
      # binding.pry
      report_generator_class.generate_report
    end
  end

  def upload_report_to_s3
  end

  def update_export_path
  end
end
