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
    count = 30
    results = {}
    loop do
      durations = (Time.zone.now.to_date..count.days.from_now.to_date).to_a.map do |item|
        [item.day, item.month].join('-')
      end
      results = where("CONCAT(extract(DAY from feastday), '-', extract(MONTH from feastday)) IN (?)", durations)
        .group_by(&:feastday)
        .map do |date, people|
          year = if Time.zone.now.month > date.month
                   Time.zone.now.year + 1
                 else
                   Time.zone.now.year
                 end
          [Date.new(year, date.month, date.day), people]
        end.to_h.sort.to_h
      break if results.keys.any?
      count += 30
    end
    results
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
