class CreateGeneralSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :general_settings do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :sales_wallet_id
      t.integer :coffee_wallet_id

      t.timestamps
    end
  end
end
