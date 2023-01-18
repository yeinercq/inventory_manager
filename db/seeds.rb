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

for i in 1..3
  sale = user.sales.create!(
    client_id: Customer.find(i).id
  )
end

puts "sales has been created"

for i in 1..3
  user.exports.create!(
    status: "recordered",
    key: "ventas_report",
    data_filters: { start_date: (Date.current.beginning_of_day - (i * 3).days), end_date: Date.current.end_of_day}
  )
end

puts "Exports has been created"

for i in 1..2
  company.wallets.create!(
    name: "Wallet #{i}",
    amount: 0
  )
end

puts "Wallets has been created"
