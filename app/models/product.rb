# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  brand            :string           not null
#  description      :text
#  unit             :integer          not null
#  size             :string           not null
#  price            :decimal(10, 2)   not null
#  user_id          :bigint           not null
#  provider_id      :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  initial_quantity :integer
#  company_id       :integer
#
class Product < ApplicationRecord
  after_create :create_initial_stock

  belongs_to :user
  belongs_to :provider
  belongs_to :company

  has_many :stocks, dependent: :destroy
  has_many :movements, dependent: :destroy
  has_many :items, dependent: :destroy

  enum unit: { bulto: 1, kilo: 2, unidad: 3 }

  validates :name, :brand, :unit, :size, :price, :initial_quantity, presence: true
  validates :name, uniqueness: { scope: :company_id, message: "has already been taken", case_sensitive: false }
  validates :price, :initial_quantity, numericality: { greater_than: 0 }

  def current_stock
    stocks.last.quantity
  end

  # TODO: N+1 problem
  def current_unit_price
    if current_stock == 0
      0
    else
      stocks.last.unit_price
    end
  end

  def current_total_price
    if current_stock == 0
      0
    else
      stocks.last.total
    end
  end

  def calculate(mov_type, quantity, total)
    case mov_type
    when "input"
      new_stock       = current_stock + quantity
      new_total_price = current_total_price + total
      new_unit_price  = new_total_price / new_stock
      [ new_stock, new_unit_price, new_total_price ]
    when "output"
      new_stock       = current_stock - quantity
      new_unit_price  = current_unit_price
      new_total_price = new_unit_price * new_stock
      [ new_stock, new_unit_price, new_total_price ]
    end
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
