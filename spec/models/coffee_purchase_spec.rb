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
#
require 'rails_helper'

RSpec.describe CoffeePurchase, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
