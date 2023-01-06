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
#  product_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Movement < ApplicationRecord
  after_create :create_stock

  belongs_to :product

  has_one :stock, dependent: :destroy

  enum mov_type: { input: 1, output: 2 }
  enum mov_sub_type: { initial_stock: 1, purchase: 2, client_refund: 3, sale: 4, provider_refund: 5 }

  validates :mov_type, :mov_sub_type, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0 }
  validates_with Stocks::ValidatesStock, if: :is_output?

  scope :filter_by_date, ->(start_date, end_date) { where("movements.created_at >= ? AND movements.created_at <= ?", start_date, end_date) }

  # validate do |item|
  #   Stocks::ValidatesStock.new(item).validate
  # end

  def total_price
    quantity * unit_price
  end

  def self.total_earnings_last_month
    amount = filter_by_date(
      (Date.current - 1.months).beginning_of_month.beginning_of_day,
      (Date.current - 1.months).end_of_month.end_of_day
    ).where(mov_sub_type: 4).joins(:stock).sum(&:unit_price)

    total_arnings = Sale.total_last_month - amount
  end

  def self.total_earnings_this_month
    amount = filter_by_date(
      Date.current.beginning_of_month.beginning_of_day,
      Date.current.end_of_month.end_of_day
    ).where(mov_sub_type: 4).joins(:stock).sum(&:unit_price)

    total_arnings = Sale.total_this_month - amount
  end

  def self.total_earnings_this_year
    amount = filter_by_date(
      Date.current.beginning_of_year.beginning_of_day,
      Date.current.end_of_month.end_of_year
    ).where(mov_sub_type: 4).joins(:stock).sum(&:unit_price)

    total_arnings = Sale.total_this_year - amount
  end

  def create_stock
    if mov_sub_type == "initial_stock"
      stock = Stock.new(
        movement_id: id,
        quantity: quantity,
        unit_price: unit_price,
        total: total
      )
      stock.save
    else
      data = product.calculate(mov_type, quantity, total_price)
      stock = Stock.new(
        movement_id: id,
        quantity: data[0],
        unit_price: data[1],
        total: data[2]
      )
      stock.save
    end
  end

  private

  def is_output?
    mov_type == "output"
  end
end
