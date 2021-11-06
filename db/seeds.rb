# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(password: 'password', phone: '0123456789')
admin_person = Person.create(
  fullname: Faker::Name.name,
  christain_name: Faker::FunnyName.name,
  birthday: Faker::Date.birthday(min_age: 5, max_age: 65),
  feastday: Faker::Date.in_date_period,
  phone: '0123456789',
  active: [true, false].sample,
  gender: %w(male female).sample
)

level1 = Level.create(name: 'huynh_truong_1')
level2 = Level.create(name: 'huynh_truong_2')
level3 = Level.create(name: 'huynh_truong_3')
level4 = Level.create(name: 'du_truong')

100.times do
  Person.create(
    fullname: Faker::Name.name,
    christain_name: Faker::FunnyName.name,
    birthday: Faker::Date.birthday(min_age: 5, max_age: 65),
    feastday: Faker::Date.in_date_period,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    level: [level1, level2, level3, level4].sample,
    active: [true, false].sample,
    gender: %w(male female).sample
  )
end

leader = Person.where(active: true).order('random()').take
leader.update(role: 'leader')
vice_leader = Person.where(active: true).where.not(id: leader.id).order('random()').take.update(role: 'vice_leader')
