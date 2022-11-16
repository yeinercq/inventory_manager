class AddTransitionsToSales < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    add_column :sales, :transitions, :hstore, array: true, default: []
  end
end
