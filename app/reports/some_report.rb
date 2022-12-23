class SomeReport < TemplateClassCsv

  private

  def add_headers
    csv << ['headers']
  end

  def add_report_rows
    csv << ['report_body']
  end
end
