module ProductsHelper
  def is_available?(product)
    product.current_stock > 0
  end
end
