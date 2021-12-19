# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Roles
admin_role = Role.create(name: 'admin')
manager_role = Role.create(name: 'manager')
manager_level_role = Role.create(name: 'manager_level')

# Root admin and his relationships
admin = User.create(password: 'password', phone: '0123456789')
UserRole.create(user: admin, role: admin_role)
admin_person = Person.create(
  fullname: Faker::Name.name,
  christain_name: Faker::FunnyName.name,
  birthday: Faker::Date.birthday(min_age: 5, max_age: 65),
  feastday: Faker::Date.in_date_period,
  phone: '0123456789',
  active: [true, false].sample,
  gender: %w(male female).sample,
  user_id: admin.id
)

# Levels
level1 = Level.create(name: 'huynh_truong1')
level2 = Level.create(name: 'huynh_truong2')
level3 = Level.create(name: 'huynh_truong3')
level4 = Level.create(name: 'du_truong')
%w(chien_con1 chien_con2 chien_con3 au_nhi1 au_nhi2 au_nhi3 thieu_nhi1 thieu_nhi2 thieu_nhi3 nghia_si1 nghia_si2 nghia_si3 nghia_si4 tro_uy tro_ta hlv1 hlv2 hlv3 tuyen_uy).each do |name|
  Level.create(name: name)
end

# Seeds assistants
100.times do
  phone = Faker::PhoneNumber.phone_number.gsub(' ', '')
  user = User.create(password: 'password', phone: phone)
  UserRole.create(user: user, role: manager_role)
  Person.create(
    fullname: Faker::Name.name,
    christain_name: Faker::FunnyName.name,
    birthday: Faker::Date.birthday(min_age: 5, max_age: 65),
    feastday: Faker::Date.in_date_period,
    phone: phone,
    level: [level1, level2, level3, level4].sample,
    active: [true, false].sample,
    gender: %w(male female).sample,
    user_id: user.id
  )
end

# Seeds students
Level::STUDENT_NAMES.each do |name|
  lv = Level.find_by(name: name)
  100.times do
    Person.create(
      fullname: Faker::Name.name,
      christain_name: Faker::FunnyName.name,
      level: lv,
      active: [true, false].sample,
      gender: %w(male female).sample
    )
  end
end

# Leader and vice leader
leader = Person.joins(:level)
               .where(levels: { name: %w(huynh_truong1 huynh_truong2 huynh_truong3) })
               .where(active: true)
               .order('random()')
               .take
leader.update(role: 'leader')
vice_leader = Person.joins(:level)
                    .where(levels: { name: Level::LEADER_NAMES })
                    .where(active: true)
                    .where.not(id: leader.id)
                    .order('random()')
                    .take
                    .update(role: 'vice_leader')

people = Person.where(active: true)
               .joins(:level)
               .where(levels: { name: Level::LEADER_NAMES })
               .order('random()')
               .ids
Level.includes(:people).where(name: Level::STUDENT_NAMES).each do |lv|
  # Assign manger to each student level
  manager_ids = []
  rand(2..3).times do
    person_id = people.shift
    manager_ids << person_id
    Manager.create(level_id: lv.id, person_id: person_id, role: :assistant)
  end

  # Seed presences
  student_ids = lv.people.select(&:active).map(&:id)
  (9.months.ago.to_date..Time.zone.now.to_date).select(&:sunday?).each do |we|
    user_id = manager_ids.shuffle.first
    ids = student_ids.shuffle
    present_number = rand((ids.length - 3)..ids.length)
    PeoplePresence.create(
      person_ids: ids.first(present_number),
      level_id: lv.id,
      user_id: user_id,
      created_at: we + 9.hours,
      updated_at: we + 9.hours
    )
  end
end
