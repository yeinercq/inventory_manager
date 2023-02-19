class AddLocationReferenceToCoffeePurchases < ActiveRecord::Migration[7.0]
  def change
    add_reference :coffee_purchases, :location, foreign_key: true
  end
end
