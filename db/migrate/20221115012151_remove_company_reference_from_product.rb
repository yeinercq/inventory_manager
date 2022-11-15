class RemoveCompanyReferenceFromProduct < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :company_id, :integer
  end
end
