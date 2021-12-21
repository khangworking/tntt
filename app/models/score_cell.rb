# == Schema Information
#
# Table name: score_cells
#
#  id              :bigint           not null, primary key
#  applied_date    :date
#  modified_by     :bigint
#  score_in_number :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  person_id       :bigint
#  score_id        :bigint
#
# Indexes
#
#  index_score_cells_on_person_id  (person_id)
#  index_score_cells_on_score_id   (score_id)
#
class ScoreCell < ApplicationRecord
  belongs_to :student, foreign_key: :person_id, class_name: Person.to_s
  belongs_to :modifier, foreign_key: :modified_by, class_name: Person.to_s, optional: true
  belongs_to :score
end
