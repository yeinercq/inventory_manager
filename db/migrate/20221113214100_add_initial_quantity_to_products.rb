class AddInitialQuantityToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :initial_quantity, :integer
  end
end
