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
class GeneralSetting < ApplicationRecord
  belongs_to :company

  validates :sales_wallet_id, :coffee_wallet_id, presence: true
end
