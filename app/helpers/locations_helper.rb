module LocationsHelper
  def is_sale_location?(location)
    location.location_type == 'venta'
  end

  def is_purchase_location?(location)
    location.location_type == 'compra'
  end
end
