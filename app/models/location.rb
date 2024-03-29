# == Schema Information
#
# Table name: locations
#
#  id            :bigint           not null, primary key
#  name          :string
#  location_type :integer
#  company_id    :bigint           not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Location < ApplicationRecord
  belongs_to :company
  belongs_to :user

  has_one :wallet, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :coffee_purchases, dependent: :destroy

  validates :name, :location_type, presence: true

  enum location_type: { compra: 1, venta: 2 }

  after_create :create_wallet

  private

  def create_wallet
    Wallet.create!(
      name: "#{name}_wallet",
      amount: 0,
      location_id: id
    )
  end
end
