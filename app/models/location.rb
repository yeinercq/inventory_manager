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

  validates :name, presence: true

  enum location_type: { purchase: 1, sale: 2 }
end
