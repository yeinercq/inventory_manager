class AddPricesAndWeightsToGeneralSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :general_settings, :base_seco_coffee_price, :decimal, precision: 10, scale: 2
    add_column :general_settings, :base_verde_coffee_price, :decimal, precision: 10, scale: 2
    add_column :general_settings, :base_pasilla_coffee_price, :decimal, precision: 10, scale: 2
    add_column :general_settings, :sample_seco_weight_quantity, :decimal, precision: 5, scale: 2
    add_column :general_settings, :sample_verde_weight_quantity, :decimal, precision: 5, scale: 2
    add_column :general_settings, :sample_pasilla_weight_quantity, :decimal, precision: 5, scale: 2
  end
end
