# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  codel       :string
#  user_id     :bigint           not null
#  customer_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  has_many :items, dependent: :destroy
end
