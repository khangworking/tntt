# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  birthday       :date
#  christain_name :string
#  feastday       :date
#  fullname       :string
#  gender         :string           default("male")
#  phone          :string
#  role           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  level_id       :bigint
#
class Person < ApplicationRecord
  validates :fullname, presence: true

  belongs_to :level, optional: true

  before_validation :strip_name

  enum gender: { male: 'male', female: 'female' }
  enum role: { leader: 'leader', vice_leader: 'vice_leader' }

  def self.next_feastday_persons
    Person.where(feastday: Person.where('feastday > CURRENT_DATE').order(:feastday).select('feastday').limit(1))
  end

  def first_name
    fullname.split(' ')[-1]
  end

  private

  def strip_name
    self.fullname = self.fullname.strip
    self.christain_name = self.christain_name.strip
    self.phone = self.phone.strip
  end
end
