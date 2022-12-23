require 'rails_helper'

RSpec.describe SomeReport do
  describe '#generate_report' do
    let(:csv_data) { [] } # we can pass CSV data as an empty array
    # We expect below data in our report
    let(:expected_data) { [['headers'], ['report_body']] }
    let(:report_class) { SomeReport.new(csv_data) }
    before { report_class.generate_report }

    it 'generates correct data' do
      expect(csv_data).to eq expected_data
    end
  end
end
