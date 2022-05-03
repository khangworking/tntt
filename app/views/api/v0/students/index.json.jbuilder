json.ignore_nil!
json.results @resources, partial: 'api/v0/students/student', as: :student
json.partial! 'api/pagy_info', resources: @resources
