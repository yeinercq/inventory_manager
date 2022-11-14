class Stocks::ValidatesStock < ActiveModel::Validator
  def validate(record)
    current_stock = record.product.current_stock
    if current_stock < record.quantity
      record.errors.add :base, "There's not enough stock. Max.: #{current_stock}"
    end
  end
end
