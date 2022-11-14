# == Schema Information
#
# Table name: providers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint           not null
#
FactoryBot.define do
  factory :provider do
    name { Faker::Commerce.product_name }
    sequence(:email) { |n| "provider#{n}@mail.com" }
    phone_number { '1234567' }
    company
  end
end
