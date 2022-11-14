# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  id_number    :string           not null
#  address      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint           not null
#
FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    sequence(:email) { |n| "provider#{n}@mail.com" }
    phone_number { '1234567' }
    sequence(:id_number) { |n| "12345#{n}" }
    address { "Valencia de la Paz" }
    company
  end
end
