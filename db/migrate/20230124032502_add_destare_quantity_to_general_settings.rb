class AddDestareQuantityToGeneralSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :general_settings, :destare_quantity, :decimal, precision: 5, scale: 2
  end
end
