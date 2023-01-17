class AddCompanyReferenceToWallets < ActiveRecord::Migration[7.0]
  def change
    add_reference :wallets, :company, null: false, foreign_key: true
  end
end
