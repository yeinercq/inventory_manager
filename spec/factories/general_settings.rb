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
FactoryBot.define do
  factory :general_setting do
    company { nil }
    sales_wallet_id { 1 }
    coffee_wallet_id { 1 }
  end
end
