# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  id_number    :string           not null
#  address      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint           not null
#
class Customer < ApplicationRecord
  include Filterable

  belongs_to :company

  has_many :coffee_purchases

  validates :name, :email, :phone_number, :id_number, :address, presence: true
  validates :name, :email, uniqueness: {scope: :company_id, message: "has already been taken", case_sensitive: false}
  validates :phone_number, numericality: { only_integer: true, greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }
  scope :filter_by_id_number, -> (id_number) { where('id_number LIKE ?', "%#{id_number}%") }
  scope :filter_by_company_id, -> (company_id) { where('company_id = ?', company_id) }

  broadcasts_to ->(customer) { [customer.company, "customers"] }, inserts_by: :prepend

  before_save :normalize_email

  def normalize_email
    self.email = email.downcase if email
  end
end
