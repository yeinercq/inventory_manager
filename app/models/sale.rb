# == Schema Information
#
# Table name: sales
#
#  id         :bigint           not null, primary key
#  total      :decimal(10, 2)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#  client_id  :bigint           not null
#
class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client, class_name: 'Customer'

  has_many :items, dependent: :destroy
  has_many :products, through: :items

  delegate :company, to: :user

  before_create :generate_code

  def generate_code
    Sales::GenerateCode.new.call(self)
  end
end
