# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  brand            :string           not null
#  description      :text
#  unit             :integer          not null
#  size             :string           not null
#  price            :decimal(10, 2)   not null
#  user_id          :bigint           not null
#  provider_id      :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  initial_quantity :integer
#  company_id       :bigint           not null
#
FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    brand { Faker::Commerce.brand }
    description { Faker::Commerce.material }
    size { "50Kg" }
    price { Faker::Commerce.price }
    initial_quantity { 100 }
    user
    provider
    company

    trait :kilo do
      unit { 1 }
    end
    trait :bulto do
      unit { 2 }
    end
    trait :unidad do
      unit { 3 }
    end

    after(:build) do |product, _|
      product.unit = "bulto"
      product.save
    end
  end
end