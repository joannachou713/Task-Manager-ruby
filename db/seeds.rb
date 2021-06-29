# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.new(id: 0, name: 'Test', email:'joannachou713@gmail.com', tel: '0912345678', password: 'testtest', password_confirmation: 'testtest', admin: true)
tel = '0912345678'
30.times do |n|
  name = Faker::FunnyName.name
  email = Faker::Internet.email
  password = 'password'
  User.create!(name: name, email: email,tel: tel, password: password, password_confirmation: password)
end
