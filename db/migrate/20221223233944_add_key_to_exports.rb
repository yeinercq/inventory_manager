class AddKeyToExports < ActiveRecord::Migration[7.0]
  def change
    add_column :exports, :key, :string
  end
end
