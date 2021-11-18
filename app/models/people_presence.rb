# == Schema Information
#
# Table name: people_presences
#
#  id         :bigint           not null, primary key
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

  def self.today
    where('DATE(created_at) = ?', Time.zone.now.to_date).take
  end
end
