company = Company.create!(name: "Coopkahawa")

puts "Company has been created"

user = company.users.create!(
  email: "yeiner@cafekahawa.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "User has been created"

provider = company.providers.create!(
  name: "Nitrosoil SAS",
  email: "sales@nitrosil.com",
  phone_number: "3131234567"
)

puts "Provider has been created"

customer = company.customers.create!(
  name: "Andres Aldana",
  email: "andres@aldana.com",
  phone_number: "3131111111",
  id_number: "1234567890",
  address: "Valencia de la Paz"
)

puts "Customer has been created"

user.products.create!(
  name: "15-15-15",
  brand: "Nitrosil",
  description: "Bulto 50kg",
  unit: "bulto",
  size: "50Kg",
  price: 980,
  provider: provider,
  initial_quantity: 100,
  company: user.company
)

puts "Product has been created"

user.sales.create!(
    client: customer
)

puts "Sale has been created"
