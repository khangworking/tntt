# == Schema Information
#
# Table name: managers
#
#  id         :bigint           not null, primary key
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level_id   :bigint
#  person_id  :bigint
#
# Indexes
#
#  index_managers_on_level_id   (level_id)
#  index_managers_on_person_id  (person_id)
#
class Manager < ApplicationRecord
  belongs_to :person
  belongs_to :level

  enum role: { assistant: 'assitant', teach: 'teach' }

  validates :person_id, uniqueness: { scope: :level_id }
end
