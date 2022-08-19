# == Schema Information
#
# Table name: levels
#
#  id         :bigint           not null, primary key
#  name       :string
#  sort_order :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Level < ApplicationRecord
  LEADER_NAMES = %w(du_truong huynh_truong1 huynh_truong2 huynh_truong3 tro_uy tro_ta).freeze
  STUDENT_NAMES = %w(chien_con1 chien_con2 chien_con3 au_nhi1 au_nhi2 au_nhi3 thieu_nhi1 thieu_nhi2 thieu_nhi3 nghia_si1 nghia_si2 nghia_si3 nghia_si4).freeze
  has_many :people
  has_many :active_people, -> { where(active: true) }, class_name: Person.to_s
  has_many :managers

  scope :students, -> { where(name: STUDENT_NAMES).order(:sort_order) }

  accepts_nested_attributes_for :managers, allow_destroy: true, reject_if: :blank_person

  private

  def blank_person(attr)
    attr['person_id'].blank?
  end
end
