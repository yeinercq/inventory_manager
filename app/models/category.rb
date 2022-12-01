# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
class Category < ApplicationRecord
  has_many :products
  belongs_to :company

  validates :name, :description, presence: true
  validates :name, uniqueness: {scope: :company_id, message: "has already been taken", case_sensitive: false}
end
