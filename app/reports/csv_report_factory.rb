class CsvReportFactory
  # we can eventually move below code to the other class, like CsvReportErrors
  # and use something like CsvReportErrors < StandardError and
  # NoReportKeyProvided < CsvReportErrors class NoReportKeyProvided < StandardError; end
  def self.for(key)
    raise NoReportKeyProvided if key.blank?
    key.classify.constantize
  end
end
