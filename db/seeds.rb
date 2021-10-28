# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
  Person.create(
    fullname: Faker::Name.name,
    christain_name: Faker::FunnyName.name,
    birthday: Faker::Date.birthday(min_age: 5, max_age: 65),
    feastday: Faker::Date.in_date_period,
    phone: Faker::PhoneNumber.cell_phone_in_e164
  )
end
