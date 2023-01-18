class AddNameToWallets < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :name, :string, null: false
  end
end
