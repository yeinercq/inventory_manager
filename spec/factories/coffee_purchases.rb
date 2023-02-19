# == Schema Information
#
# Table name: coffee_purchases
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  client_id               :bigint           not null
#  quantity                :decimal(10, 2)
#  coffee_type             :integer
#  base_purchase_price     :decimal(10, 2)
#  packs_count             :integer
#  sample_quantity         :decimal(5, 2)
#  decrease_quantity       :decimal(5, 2)
#  sieve_quantity          :decimal(5, 2)
#  healthy_almond_quantity :decimal(5, 2)
#  pasilla_quantity        :decimal(5, 2)
#  factor_rate             :decimal(5, 2)
#  purchase_price          :decimal(10, 2)
#  code                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  destare_quantity        :decimal(5, 2)
#  status                  :string
#  transitions             :hstore           is an Array
#  location_id             :bigint
#
FactoryBot.define do
  factory :coffee_purchase do
    user { nil }
    customer { nil }
    quantity { "9.99" }
    coffee_type { 1 }
    base_purchase_price { "9.99" }
    packs_count { 1 }
    sample_quantity { "9.99" }
    decrease_quantity { "9.99" }
    sieve_quantity { "9.99" }
    healthy_almond_quantity { "9.99" }
    pasilla_quantity { "9.99" }
    factor_rate { "9.99" }
    computed_purchase_price { "9.99" }
  end
end
