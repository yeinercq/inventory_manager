class AddMovementReferenceToStock < ActiveRecord::Migration[7.0]
  def change
    add_reference :stocks, :movement, null: false, foreign_key: true
  end
end
