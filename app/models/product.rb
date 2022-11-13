# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  brand       :string           not null
#  description :text
#  unit        :integer          not null
#  size        :string           not null
#  price       :decimal(10, 2)   not null
#  user_id     :bigint           not null
#  provider_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :user
  belongs_to :provider

  enum unit: { bulto: 1, kilo: 2, unidad: 3 }
end
