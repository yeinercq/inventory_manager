class RemoveCodelFromSales < ActiveRecord::Migration[7.0]
  def change
    remove_column :sales, :codel, :string
  end
end
