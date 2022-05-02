json.ignore_nil!
json.results @resources, partial: 'api/students/student', as: :student
json.partial! 'api/pagy_info', resources: @resources
