# == Schema Information
#
# Table name: general_settings
#
#  id                             :bigint           not null, primary key
#  company_id                     :bigint           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  base_seco_coffee_price         :decimal(10, 2)
#  base_verde_coffee_price        :decimal(10, 2)
#  base_pasilla_coffee_price      :decimal(10, 2)
#  sample_seco_weight_quantity    :decimal(5, 2)
#  sample_verde_weight_quantity   :decimal(5, 2)
#  sample_pasilla_weight_quantity :decimal(5, 2)
#  destare_quantity               :decimal(5, 2)
#
require 'rails_helper'

RSpec.describe GeneralSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
