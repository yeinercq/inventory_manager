class AddCodeToWallets < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :code, :string
  end
end