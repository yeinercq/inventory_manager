class AddMovementReferenceToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :movement, null: false, foreign_key: true
  end
end
