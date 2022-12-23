require 'rails_helper'

RSpec.describe CsvReportFactory do
  describe '.for' do
    context 'some_report' do
      let(:report_key) { :some_report }
      let(:expected_report_class) { SomeReport }

      it 'returns correct class' do
        expect(CsvReportFactory.for('some_report')).to eq SomeReport
      end
    end
  end
end
