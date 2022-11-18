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
class SalePrice < ApplicationRecord
  belongs_to :product

  validates :price, presence: true, numericality: { greater_than: 0 }
end
