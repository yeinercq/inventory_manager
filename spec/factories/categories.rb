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
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    description { "Description" }
    company
  end
end
