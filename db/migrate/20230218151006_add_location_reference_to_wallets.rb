class AddLocationReferenceToWallets < ActiveRecord::Migration[7.0]
  def change
    add_reference :wallets, :location, foreign_key: true, index: true 
  end
end
