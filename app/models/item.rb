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
class Item < ApplicationRecord
  after_create :create_movement
  before_destroy :destroy_movement

  belongs_to :sale
  belongs_to :product
  has_one :movement, dependent: :destroy

  validates :quantity, :unit_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0 }
  validates :product_id, uniqueness: { scope: :sale_id, message: "has already been taken" }
  validates_with Stocks::ValidatesStock
  # validate do |item|
  #   Stocks::ValidatesStock.new(item).validate
  # end

  def create_movement
    Movement.create(
      mov_type: "output",
      mov_sub_type: "sale",
      quantity: quantity,
      unit_price: unit_price,
      total: total_price,
      product_id: product_id,
      item_id: id
    )
  end

  def destroy_movement
    movement.destroy
  end

  def total_price
    quantity * unit_price
  end
end
