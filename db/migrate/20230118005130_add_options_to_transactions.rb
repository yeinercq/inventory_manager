class AddOptionsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :options, :hstore
  end
end
