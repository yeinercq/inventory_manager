class AddItemReferenceToMovements < ActiveRecord::Migration[7.0]
  def change
    add_reference :movements, :item, foreign_key: true
  end
end
