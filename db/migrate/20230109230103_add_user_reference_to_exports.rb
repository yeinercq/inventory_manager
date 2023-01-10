class AddUserReferenceToExports < ActiveRecord::Migration[7.0]
  def change
    add_reference :exports, :user, null: false, foreign_key: true
  end
end
