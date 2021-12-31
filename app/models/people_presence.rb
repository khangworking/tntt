# == Schema Information
#
# Table name: people_presences
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE)
#  person_ids :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_people_presences_on_level_id  (level_id)
#  index_people_presences_on_user_id   (user_id)
#
class PeoplePresence < ApplicationRecord
  serialize :person_ids, Array

  belongs_to :user
  belongs_to :level

  validates :person_ids, presence: true

  scope :unarchived, -> { where(archived: false) }

  class << self
    def today
      unarchived.where('DATE(created_at) = ?', Time.zone.now.to_date).take
    end

    def process_score_cells
      unarchived.where('DATE(created_at) = ?', 1.days.ago.to_date).each(&:generate_score_cells!)
    end
  end

  def generate_score_cells!
    active_score = level.active_score
    return unless active_score

    transaction do
      person_ids.each do |ps|
        active_score.score_cells.create!(
          applied_date: created_at.to_date,
          score_in_number: 1,
          person_id: ps,
          score_type: :presence
        )
      end
      update!(archived: true)
    end
  end
end
