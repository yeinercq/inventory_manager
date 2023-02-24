class CafeReport < TemplateClassCsv
  # require 'pry'

  private

  def add_headers
    csv << [
      'Codigo de compra',
      'Estado de factura',
      'Fecha de creacion',
      'Ubicacion',
      'Identificacion cliente',
      'Nombre',
      'Tipo de cafe',
      'Cantidad (kg)',
      'Cantidad tulas',
      'Merma (gr)',
      'Zaranda (gr)',
      'Almendra sana (gr)',
      'Pasilla (gr)',
      'Precio base',
      'Factor de rendimiento',
      'Destare por tula (gr)',
      'Precio de pago (kg)',
      'Precio total'
    ]
  end

  def add_report_rows
    purchases = CoffeePurchase.filter_by_date(
      Date.parse(data_filters["start_date"]).beginning_of_day,
      Date.parse(data_filters["end_date"]).end_of_day
    )
    purchases.each do |purchase|
      csv << [
        purchase.code.to_s,
        purchase.status.to_s,
        purchase.created_at.to_s,
        purchase.location.name,
        purchase.client.id_number.to_s,
        purchase.client.name.to_s,
        purchase.coffee_type.to_s,
        purchase.quantity.to_s,
        purchase.packs_count.to_s,
        purchase.decrease_quantity.to_s,
        purchase.sieve_quantity.to_s,
        purchase.healthy_almond_quantity.to_s,
        purchase.pasilla_quantity.to_s,
        purchase.base_purchase_price.to_s,
        purchase.factor_rate.to_s,
        purchase.destare_quantity.to_s,
        purchase.purchase_price.to_s,
        purchase.total_price.to_s
      ]
    end
  end
end
