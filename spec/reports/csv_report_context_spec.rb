require 'rails_helper'

RSpec.describe CsvReportContext do
  describe '#determine_strategy' do
    context 'some_report' do
      let(:report_key) { :some_report }
      let(:csv_report_context) { CsvReportContext.new(report_key) }
      let(:strategy_class) { csv_report_context.determine_strategy }

      it 'returns correct strategy class' do
        expect(strategy_class).to eq SomeReportStrategy
      end
    end
  end

  describe SomeReportStrategy do
    describe '.generate_report' do
      let(:csv_data) { [] }
      let(:expected_data) { [['headers'], ['report_body']] }

      before { SomeReportStrategy.generate_report(csv_data) }

      it 'generates correct data' do
        expect(csv_data).to eq expected_data
      end
    end
  end
end
