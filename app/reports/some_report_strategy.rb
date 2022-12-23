class SomeReportStrategy
  def self.generate_report(csv)
    add_headers(csv)
    add_report_rows(csv)
  end

  def self.add_headers(csv)
    csv << ['headers']
  end

  def self.add_report_rows(csv)
    csv << ['report_body']
  end
end
