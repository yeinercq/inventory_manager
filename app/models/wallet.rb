# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
class Wallet < ApplicationRecord
  belongs_to :company

  has_many :transactions

  validates :amount, presence: true
  # validates :amount, numericality: { greater_than: 0 }

  def current_amount
    amount
  end
end
