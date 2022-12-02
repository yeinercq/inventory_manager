# == Schema Information
#
# Table name: sale_prices
#
#  id          :bigint           not null, primary key
#  price       :decimal(10, 2)   not null
#  product_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  transitions :hstore           is an Array
#
require 'rails_helper'

RSpec.describe SalePrice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
