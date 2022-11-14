class RemoveCustomerReferenceFromSales < ActiveRecord::Migration[7.0]
  def change
    remove_column :sales, :customer_id, :integer
  end
end
