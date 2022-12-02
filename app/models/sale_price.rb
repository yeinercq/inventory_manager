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
class SalePrice < ApplicationRecord
  belongs_to :product

  validates :price, presence: true, numericality: { greater_than: 0 }

  before_create :log_sale_price_change
  before_update :log_sale_price_change

  def log_sale_price_change
    transitions.push(
      {
        new_sale_price: price,
        user_id: product.user.id,
        timestamp: Time.zone.now
      }
    )
  end
end
