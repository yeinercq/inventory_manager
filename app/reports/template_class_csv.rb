class TemplateClassCsv
  require 'csv'

  def initialize(csv, data_filters)
    @csv = csv
    @data_filters = data_filters
  end

  def generate_report
    add_headers
    add_report_rows
  end

  private

  attr_accessor :csv, :data_filters

  def add_headers
    raise NotImplementedError
  end

  def add_report_rows
    raise NotImplementedError
  end
end
