class RemoveStockReferenceFromMovements < ActiveRecord::Migration[7.0]
  def change
    remove_column :movements, :stock_id, :integer
  end
end
