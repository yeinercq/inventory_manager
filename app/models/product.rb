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
#  company_id       :bigint           not null
#  picture          :string
#  category_id      :bigint
#
class Product < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :provider
  belongs_to :company
  belongs_to :category

  has_many :movements, dependent: :destroy
  has_many :stocks, through: :movements
  has_many :items, dependent: :destroy # TODO: ajust association with items-sales
  has_many :sales, through: :items
  has_one :sale_price, dependent: :destroy

  enum unit: { bulto: 1, kilo: 2, unidad: 3 }

  scope :ordered, -> { order(id: :desc) }
  scope :sale_priced, -> { joins(:sale_price) }
  scope :filter_by_name, -> (name) { where('name LIKE ?', "%#{name}%") }
  scope :filter_by_company_id, -> (company_id) { where('company_id = ?', company_id) }


  mount_uploader :picture, PictureUploader

  validates :name, :brand, :unit, :size, :price, :initial_quantity, presence: true
  validates :name, uniqueness: { scope: :company_id, message: "has already been taken", case_sensitive: false }
  validates :price, :initial_quantity, numericality: { greater_than: 0 }
  validate :picture_size

  broadcasts_to ->(product) { [product.company, "products"] }, inserts_by: :prepend
  after_create :create_initial_stock

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

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 3.megabytes
      errors.add(:picture, "should be less than 3MB")
    end
  end


  def create_initial_stock
    self.movements.create(
      mov_type: "input",
      mov_sub_type: "initial_stock",
      quantity: initial_quantity,
      unit_price: price,
      total: initial_total_stock_price
    )
  end

  def initial_total_stock_price
    initial_quantity * price
  end
end
