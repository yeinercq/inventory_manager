class AddCodeToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :code, :string
  end
end
