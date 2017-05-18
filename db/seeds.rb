# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Horace Wittel",
             email: "horace@handpnyc.com",
             password: "Garfunkel",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "fake-#{n+1}@example.com"
  password = "Qwerty1234"
  User.create!(name: name, email: email, password: password, activated: true, activated_at: Time.zone.now)
end