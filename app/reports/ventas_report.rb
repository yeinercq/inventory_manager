class VentasReport < TemplateClassCsv
  # require 'pry'

  private

  def add_headers
    csv << [
      'Codigo de factura',
      'Estado de factura',
      'Ubicacion',
      'Fecha de creacion',
      'Identificacion cliente',
      'Nombre',
      'Precio total',
      'Cantidad de productos'
    ]
  end

  def add_report_rows
    sales = Sale.filter_by_date(
      Date.parse(data_filters["start_date"]).beginning_of_day,
      Date.parse(data_filters["end_date"]).end_of_day
    )
    sales.each do |sale|
      csv << [
        sale.code.to_s,
        sale.status,
        sale.location.name,
        sale.created_at.to_s,
        sale.client.id_number.to_s,
        sale.client.name.to_s,
        sale.total_price.to_s,
        sale.products.count.to_s
      ]
    end
  end
end
