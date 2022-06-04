json.teachers_count @teachers_count
json.seniors_count @seniors_count
json.students_count @students_count
json.feastday do
  json.date @feastday.keys[0]
  json.people @feastday[@feastday.keys[0]], partial: 'api/v0/person', as: :student
end
