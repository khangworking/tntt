# == Schema Information
#
# Table name: level_scores
#
#  id           :bigint           not null, primary key
#  date_chain   :string
#  note         :text
#  score_number :float            default(0.0)
#  score_type   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  level_id     :bigint
#  person_id    :bigint
#
# Indexes
#
#  index_level_scores_on_level_id   (level_id)
#  index_level_scores_on_person_id  (person_id)
#
class LevelScore < ApplicationRecord
  belongs_to :person
  belongs_to :level

  enum score_type: {
    presence: 'presence',
    examinate: 'examinate'
  }

  def self.new_presence_score(person, date_chain, level_id)
    new(
      person_id: person.id,
      date_chain: date_chain,
      score_type: 'presence',
      level_id: level_id,
      score_number: 1.0
    )
  end

end
