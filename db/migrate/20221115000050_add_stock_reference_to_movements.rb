class AddStockReferenceToMovements < ActiveRecord::Migration[7.0]
  def change
    add_reference :movements, :stock, null: false, foreign_key: true
  end
end
