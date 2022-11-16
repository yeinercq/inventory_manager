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
    # invoice_with_items will create items data after the invoice has been created
    factory :sale_with_items do
      # items_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        items_count { 3 }
      end
      # the after(:create) yields two values; the innvoice instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the invoice is associated properly to the item
      after(:build) do |sale, evaluator|
        create_list(:item, evaluator.items_count, sale: sale)

        # You may need to reload the record here, depending on your application
        sale.reload
      end
    end
  end
end
