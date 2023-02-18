# == Schema Information
#
# Table name: locations
#
#  id            :bigint           not null, primary key
#  name          :string
#  location_type :integer
#  company_id    :bigint           not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :location do
    name { "MyString" }
    location_type { 1 }
    company { nil }
    user { nil }
  end
end
