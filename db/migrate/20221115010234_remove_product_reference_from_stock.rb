class RemoveProductReferenceFromStock < ActiveRecord::Migration[7.0]
  def change
    remove_column :stocks, :product_id, :integer
  end
end
