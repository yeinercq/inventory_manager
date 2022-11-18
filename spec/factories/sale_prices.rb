# == Schema Information
#
# Table name: sale_prices
#
#  id         :bigint           not null, primary key
#  price      :decimal(10, 2)   not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :sale_price do
    price { "9.99" }
    product { nil }
  end
end
