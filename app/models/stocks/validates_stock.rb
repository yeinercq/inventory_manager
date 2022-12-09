class Stocks::ValidatesStock < ActiveModel::Validator
  def validate(record)
    product = Product.find(record.product.id)
    current_stock = product.current_stock
    # binding.pry
    if current_stock < record.quantity
      record.errors.add :base, "There's not enough stock. Max.: #{current_stock}"
    end
  end

  # def initialize(item)
  #   @item = item
  # end
  #
  # def validate
  #   current_stock = @item.product.current_stock
  #   # binding.pry
  #   if current_stock < @item.quantity
  #     @item.errors.add :base, "There's not enough stock. Max.: #{current_stock}"
  #   end
  # end
end
