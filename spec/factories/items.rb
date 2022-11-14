# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  unit_price :decimal(10, 2)   not null
#  sale_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :item do
    quantity { 1 }
    unit_price { 1012 }
    sale
    product
  end
end
