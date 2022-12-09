# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  name        :string
#  title       :string
#  description :text
#  picture     :string
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    title { Faker::Company.profession }
    description { Faker::Company.profession }
    picture { "picture_url" }
    user
  end
end
