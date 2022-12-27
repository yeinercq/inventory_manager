require 'rails_helper'

RSpec.describe Reports::CsvReportGeneratorService do
  describe '#generate', :vcr do
    let(:export) { create(:export) }
    subject(:csv_generator) { described_class.new(export: export) }
    let(:bucket) { Rails.application.credentials.dig(:aws, :bucket) }
    let(:s3_resource) { AMAZON_S3_RESOURCE }
    let(:s3_obj) { s3_resource.bucket(bucket).object(export.file_path) }
    let(:report_file) { s3_obj.get.body.string }
    let(:csv_file_data) { CSV.parse report_file }
    let(:csv_expected_data) { [['headers'], ['report_body']] } # Here we may define expected data

    context 'with a valid export' do
      # before(:each) { csv_generator.generate }
      it 'should return success and generates reports' do
        success, message = csv_generator.generate
        expect(success).to eq true
        expect(message).to eq "successful"
        expect(report_file).not_to be_nil
        expect(csv_file_data).to eq csv_expected_data
      end
    end
  end
end
