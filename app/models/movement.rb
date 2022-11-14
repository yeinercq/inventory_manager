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
class Movement < ApplicationRecord
  after_create :create_stock

  belongs_to :user
  belongs_to :product

  enum mov_type: { input: 1, output: 2 }
  enum mov_sub_type: { purchase: 1, client_refund: 2, sale: 3, provider_refund: 4 }

  validates :mov_type, :mov_sub_type, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0 }
  validates_with Stocks::ValidatesStock, if: :is_output?

  def total_price
    quantity * unit_price
  end

  def create_stock
    data = product.calculate(mov_type, quantity, total_price)
    Stock.create(
      quantity: data[0],
      unit_price: data[1],
      total: data[2],
      product: product
    )
  end

  def is_output?
    mov_type == "output"
  end
end
