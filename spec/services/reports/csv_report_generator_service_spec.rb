require 'rails_helper'

RSpec.describe Reports::CsvReportGeneratorService do
  describe '#generate', :vcr do
    let(:export) { create(:export) }
    subject(:csv_generator) { described_class.new(export: export) }
    # let(:client) { Aws::S3::Client.new }
    let(:client) { AMAZON_S3_CLIENT }
    let(:report_file) { client.get_object export.file_path }
    let(:csv_file_data) { CSV.parse report_file }
    let(:csv_expected_data) { [] } # Here we may define expected data

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
