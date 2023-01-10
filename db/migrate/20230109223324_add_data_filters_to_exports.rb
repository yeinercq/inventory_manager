class AddDataFiltersToExports < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    add_column :exports, :data_filters, :hstore, default: {}
  end
end
