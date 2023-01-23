class CreateCoffeePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :coffee_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: { to_table: :customers }, index: true
      t.decimal :quantity, precision: 10, scale: 2
      t.integer :coffee_type
      t.decimal :base_purchase_price, precision: 10, scale: 2
      t.integer :packs_count
      t.decimal :sample_quantity, precision: 5, scale: 2
      t.decimal :decrease_quantity, precision: 5, scale: 2
      t.decimal :sieve_quantity, precision: 5, scale: 2
      t.decimal :healthy_almond_quantity, precision: 5, scale: 2
      t.decimal :pasilla_quantity, precision: 5, scale: 2
      t.decimal :factor_rate, precision: 5, scale: 2
      t.decimal :purchase_price, precision: 10, scale: 2
      t.string :code

      t.timestamps
    end
  end
end
