# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  brand       :string           not null
#  description :text
#  unit        :integer          not null
#  size        :string           not null
#  price       :decimal(10, 2)   not null
#  user_id     :bigint           not null
#  provider_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  after_create :create_initial_stock

  belongs_to :user
  belongs_to :provider

  has_many :stocks

  enum unit: { bulto: 1, kilo: 2, unidad: 3 }

  validates :name, :brand, :unit, :size, :price, :initial_quantity, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :price, :initial_quantity, numericality: { greater_than: 0 }

  def current_stock
    stocks.last.quantity
  end

  private

  def create_initial_stock
    Stock.create(
      quantity: initial_quantity,
      unit_price: price,
      total: initial_total_stock_price,
      product: self
    )
  end

  def initial_total_stock_price
    initial_quantity * price
  end
end
