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

  class << self
    def new_presence_score(person, date_chain, level_id)
      person_id = person.is_a?(Person) ? person.id : person
      new(
        person_id: person_id,
        date_chain: date_chain,
        score_type: 'presence',
        level_id: level_id,
        score_number: 1.0
      )
    end

    def create_presence_scores(person_ids:, date_chain:, level_id:)
      person_ids.each do |id|
        new_obj = new_presence_score(id, date_chain, level_id)
        new_obj.save
      end
    end
  end

end
