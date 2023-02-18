# == Schema Information
#
# Table name: wallets
#
#  id          :bigint           not null, primary key
#  amount      :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string
#  name        :string           not null
#  location_id :bigint
#
FactoryBot.define do
  factory :wallet do
    amount { "9.99" }
  end
end
