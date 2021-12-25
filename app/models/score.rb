# == Schema Information
#
# Table name: scores
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  start_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level_id   :bigint
#
# Indexes
#
#  index_scores_on_level_id  (level_id)
#
class Score < ApplicationRecord
  belongs_to :level
  has_many :score_cells

  def latest_date
    score_cells.order(applied_date: :desc).take.applied_date
  end

  def first_date
    score_cells.order(applied_date: :asc).take.applied_date
  end
end
