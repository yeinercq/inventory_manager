class CsvReportContext
  def initialize(report_key)
    @report_key = report_key
  end

  def determine_strategy
    report_key_based_strategy
  end

  private

  attr_accessor :report_key

  def report_key_based_strategy
    raise NoReportKeyProvided if report_key.blank?

    case report_key
    when :some_report then SomeReportStrategy
    when :other_report then OtherReportStrategy
    else raise InvalidReportKey
    end
  end
end
