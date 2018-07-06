5.times do |n|
  name  = Faker::Name.name
  description = Faker::Lorem.sentences
  Menu.create!(name:  name,
               description: description,
               )
end
