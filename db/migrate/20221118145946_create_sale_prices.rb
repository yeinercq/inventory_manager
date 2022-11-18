class CreateSalePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_prices do |t|
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
