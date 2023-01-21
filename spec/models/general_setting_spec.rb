# == Schema Information
#
# Table name: general_settings
#
#  id               :bigint           not null, primary key
#  company_id       :bigint           not null
#  sales_wallet_id  :integer
#  coffee_wallet_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe GeneralSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
