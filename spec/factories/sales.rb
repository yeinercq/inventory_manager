# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string
#  client_id   :bigint           not null
#  status      :string
#  transitions :hstore           is an Array
#
FactoryBot.define do
  factory :sale do
    user
    association :client, factory: :customer

    # user_with_posts will create post data after the user has been created
    factory :sale_with_items do
      items { [association(:item)] }
    end
  end
end
