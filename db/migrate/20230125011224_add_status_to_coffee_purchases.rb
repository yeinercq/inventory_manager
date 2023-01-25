class AddStatusToCoffeePurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :coffee_purchases, :status, :string
    add_column :coffee_purchases, :transitions, :hstore, array: true, default: []
  end
end
