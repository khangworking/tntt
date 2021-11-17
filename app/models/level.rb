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
  STUDENT_NAMES = %w(chien_con1 chien_con2 chien_con3 au_nhi1 au_nhi2 au_nhi3 thieu_nhi1 thieu_nhi2 thieu_nhi3 nghia_si1 nghia_si2 nghia_si3 nghia_si4)
  has_many :people
  has_many :managers
end
