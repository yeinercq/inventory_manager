# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
FactoryBot.define do
  factory :wallet do
    amount { "9.99" }
  end
end
