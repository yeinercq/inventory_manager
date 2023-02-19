class AddLocationReferencesToSales < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :location, foreign_key: true
  end
end
