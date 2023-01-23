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
class CoffeePurchase < ApplicationRecord
  # { client_id: client.id, quantity: 100, coffee_type: "seco", base_purchase_price: 970000.00, packs_count: 2, sample_quantity: 250.0, decrease_quantity: 202.2, sieve_quantity: 1, healthy_almond_quantity: 195.0, pasilla_quantity: 6 }

  belongs_to :user
  belongs_to :client, class_name: "Customer"

  enum coffee_type: { seco: 1, verde: 2, pasilla: 3 }

  before_create :compute_factor_price, :generate_code

  private

  def generate_code
    CoffeePurchases::GenerateCode.new.call(self)
  end

  def factor
    17500 / healthy_almond_quantity
  end

  def compute_factor_price
    self.factor_rate = factor
    self.purchase_price = ( base_purchase_price / 125 ) * 94 / factor
  end

end
