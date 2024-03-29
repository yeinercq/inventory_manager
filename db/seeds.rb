company = Company.create!(name: "Coopkahawa")
company2 = Company.create!(name: "Cadefihuila")

puts "Company has been created"

user = company.users.create!(
  email: "yeiner@cafekahawa.com",
  password: "123456",
  password_confirmation: "123456"
)

user2 = company.users.create!(
  email: "cristina@cafekahawa.com",
  password: "123456",
  password_confirmation: "123456"
)

user3 = company2.users.create!(
  email: "gilberto@cadefihuila.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "Users has been created"

GeneralSetting.create!(
  company: company,
  base_seco_coffee_price: 2000000,
  base_verde_coffee_price: 1000000,
  base_pasilla_coffee_price: 1600,
  sample_seco_weight_quantity: 250,
  sample_verde_weight_quantity: 200,
  sample_pasilla_weight_quantity: 250,
  destare_quantity: 300
)

puts "General Settings has been created"

provider = company.providers.create!(
  name: "Nitrosoil SAS",
  email: "sales@nitrosil.com",
  phone_number: "3131234567"
)

provider = company.providers.create!(
  name: "Ciamza SAS",
  email: "sales@ciamza.com",
  phone_number: "3131234567"
)

provider = company.providers.create!(
  name: "Cadefihuila SAS",
  email: "sales@cadefihuila.com",
  phone_number: "3131234567"
)

puts "Providers has been created"

customer = company.customers.create!(
  name: "Andres Aldana",
  email: "andres@mail.com",
  phone_number: "3131111111",
  id_number: "1234567890",
  address: "Valencia de la Paz"
)

customer = company.customers.create!(
  name: "Diana Bejarano",
  email: "diana@mail.com",
  phone_number: "3131111111",
  id_number: "1234567891",
  address: "Valencia de la Paz"
)

customer = company.customers.create!(
  name: "Camila Lozano",
  email: "andres@aldana.com",
  phone_number: "3131111111",
  id_number: "1234567892",
  address: "Valencia de la Paz"
)

puts "Customers has been created"

for n in 1..5
  company.categories.create!(
    name: "Category #{n}",
    description: "Description"
  )
end

puts "Categories has been created"

user.products.create!(
  name: "15-15-15",
  brand: "Nitrosil",
  description: "Bulto 50kg",
  unit: "bulto",
  size: "50Kg",
  price: 180000,
  provider: provider,
  initial_quantity: 100,
  company: user.company,
  category: Category.find(1)
)

user.products.create!(
  name: "17-6-18-2",
  brand: "Cadefihuila",
  description: "Bulto 50kg",
  unit: "bulto",
  size: "50Kg",
  price: 180000,
  provider: provider,
  initial_quantity: 100,
  company: user.company,
  category: Category.find(1)
)

user.products.create!(
  name: "24-5-25",
  brand: "Ciamza",
  description: "Bulto 50kg",
  unit: "bulto",
  size: "50Kg",
  price: 180000,
  provider: provider,
  initial_quantity: 100,
  company: user.company,
  category: Category.find(2)
)

puts "Product has been created"

location_1 = company.locations.create!(
  name: "Valencia cafe",
  location_type: "compra",
  user: user
)

location_2 = company.locations.create!(
  name: "Valencia fertilizante",
  location_type: "venta",
  user: user
)

puts "Locations has been created"

for i in 1..3
  location_2.sales.create!(
    client_id: Customer.find(i).id,
    user: user
  )
end

puts "sales has been created"

location_1.wallet.transactions.create!(
  transaction_type: "deposit",
  amount: 10000000,
  user: user
)

puts "Deposit transaction to coffe wallet has been done"

for i in 1..3
  location_1.coffee_purchases.create!(
    user: user,
    client_id: i,
    quantity: 100,
    coffee_type: "seco",
    base_purchase_price: 970000.00,
    packs_count: 2,
    sample_quantity: 250.0,
    decrease_quantity: 202.2,
    sieve_quantity: 1,
    healthy_almond_quantity: 195.0,
    pasilla_quantity: 4,
    destare_quantity: 300
  )
end

puts "Coffee purchases has been created"


# for i in 1..3
#   user.exports.create!(
#     status: "recordered",
#     key: "ventas_report",
#     data_filters: { start_date: (Date.current.beginning_of_day - (i * 3).days), end_date: Date.current.end_of_day}
#   )
# end
#
# puts "Exports has been created"
