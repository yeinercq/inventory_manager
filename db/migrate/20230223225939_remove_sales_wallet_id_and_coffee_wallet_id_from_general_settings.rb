class RemoveSalesWalletIdAndCoffeeWalletIdFromGeneralSettings < ActiveRecord::Migration[7.0]
  def change
    remove_column :general_settings, :coffee_wallet_id, :integer
    remove_column :general_settings, :sales_wallet_id, :integer
  end
end
