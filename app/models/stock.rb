# == Schema Information
#
# Table name: stocks
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  unit_price :decimal(10, 2)   not null
#  total      :decimal(10, 2)   not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Stock < ApplicationRecord
  belongs_to :product
end
