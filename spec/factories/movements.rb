# == Schema Information
#
# Table name: movements
#
#  id           :bigint           not null, primary key
#  mov_type     :integer          not null
#  mov_sub_type :integer          not null
#  quantity     :integer          not null
#  unit_price   :decimal(10, 2)   not null
#  total        :decimal(10, 2)
#  product_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint
#
FactoryBot.define do
  factory :movement do
    mov_type { "input" }
    mov_sub_type { "purchase" }
    quantity { 80 }
    unit_price { 1005 }
    product
  end
end
