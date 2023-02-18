class RemoveCompanyReferenceFromWallets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :wallets, :company, foreign_key: true
  end
end
