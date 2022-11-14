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
#  user_id      :bigint           not null
#  product_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :movement do
    mov_type { "input" }
    mov_sub_type { "purchase" }
    quantity { 80 }
    unit_price { 1005 }
    user
    product
  end
end
