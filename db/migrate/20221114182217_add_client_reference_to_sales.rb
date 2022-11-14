class AddClientReferenceToSales < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :client, null: false, foreign_key: { to_table: :customers }, index: true
  end
end
