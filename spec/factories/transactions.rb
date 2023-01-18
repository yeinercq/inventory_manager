# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_type :integer
#  amount           :decimal(10, 2)
#  wallet_id        :bigint           not null
#  user_id          :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  options          :hstore
#
FactoryBot.define do
  factory :transaction do
    transaction_type { 1 }
    amount { "9.99" }
    wallet { nil }
    user { nil }
  end
end
