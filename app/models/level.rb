# == Schema Information
#
# Table name: levels
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Level < ApplicationRecord
  LEADER_NAMES = %w(du_truong huynh_truong1 huynh_truong2 huynh_truong3)
  has_many :people
end
