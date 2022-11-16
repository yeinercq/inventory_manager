class AddStatusToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :status, :string
  end
end
