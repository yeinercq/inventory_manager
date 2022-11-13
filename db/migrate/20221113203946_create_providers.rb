class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
