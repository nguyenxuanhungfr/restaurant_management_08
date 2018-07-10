User.create!(name: 'admin', email: 'admin@example.com', password: '123456', password_confirmation: '123456')
User.create!(name: 'framgia', email: 'framgia@framgia.framgia', password: '123456', password_confirmation: '123456')

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  address = Faker::Address.street_address
  phone = Faker::PhoneNumber.phone_number
  User.create!(name:  name,
               email: email,
               address: address,
               phone: phone,
               password: password,
               password_confirmation: password)
end
