# == Schema Information
#
# Table name: sale_prices
#
#  id          :bigint           not null, primary key
#  price       :decimal(10, 2)   not null
#  product_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  transitions :hstore           is an Array
#
FactoryBot.define do
  factory :sale_price do
    price { 1020 }
    product
  end
end
