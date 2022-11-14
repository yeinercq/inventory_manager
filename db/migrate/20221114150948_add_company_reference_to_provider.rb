class AddCompanyReferenceToProvider < ActiveRecord::Migration[7.0]
  def change
    add_reference :providers, :company, null: false, foreign_key: true
  end
end
