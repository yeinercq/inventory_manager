# == Schema Information
#
# Table name: stocks
#
#  id          :bigint           not null, primary key
#  quantity    :integer          not null
#  unit_price  :decimal(10, 2)   not null
#  total       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  movement_id :bigint           not null
#
require 'rails_helper'

RSpec.describe Stock, type: :model do
end
