class TemplateClassCsv
  require 'csv'
  
  def initialize(csv)
    @csv = csv
  end

  def generate_report
    add_headers
    add_report_rows
  end

  private

  attr_accessor :csv

  def add_headers
    raise NotImplementedError
  end

  def add_report_rows
    raise NotImplementedError
  end
end
