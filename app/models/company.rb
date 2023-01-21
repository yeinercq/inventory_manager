# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :providers, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :sales, through: :users
  has_many :categories, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_one :general_setting, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
