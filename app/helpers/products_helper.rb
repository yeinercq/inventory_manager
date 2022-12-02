module ProductsHelper
  def is_available?(product)
    product.current_stock > 0
  end

  def has_category?(product)
    !product.category.nil?
  end
end
