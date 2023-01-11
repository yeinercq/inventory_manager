class SalesReport < TemplateClassCsv
  require 'pry'

  private

  def add_headers
    csv << ['Sale code', 'Created date', 'Client id number', 'Client name', 'Total price', 'Products count']
  end

  def add_report_rows
    sales = Sale.filter_by_date(data_filters["start_date"], data_filters["end_date"])
    sales.each do |sale|
      csv << [
        sale.code.to_s,
        sale.created_at.to_s,
        sale.client.id_number.to_s,
        sale.client.name.to_s,
        sale.total_price.to_s,
        sale.products.count.to_s
      ]
    end
  end
end
