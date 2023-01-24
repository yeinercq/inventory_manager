class AddDestareQuantityToCoffeePurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :coffee_purchases, :destare_quantity, :decimal, precision: 5, scale: 2
  end
end
