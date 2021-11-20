# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  address        :text
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
#  user_id        :bigint
#
# Indexes
#
#  index_people_on_user_id  (user_id)
#
class Person < ApplicationRecord
  validates :fullname, presence: true

  belongs_to :level, optional: true
  belongs_to :user, optional: true
  has_many :manage_levels, class_name: Manager.to_s
  has_many :parent_relationships, foreign_key: :child_id, class_name: PeopleRelationship.to_s
  has_many :parents, through: :parent_relationships, source: :parent
  has_many :child_relationships, foreign_key: :parent_id, class_name: PeopleRelationship.to_s
  has_many :children, through: :child_relationships, source: :child

  before_validation :strip_name

  enum gender: { male: 'male', female: 'female' }
  enum role: { leader: 'leader', vice_leader: 'vice_leader' }

  scope :order_name_alphabel, -> do
    select("substring(people.fullname, length(people.fullname) - position(' ' in reverse(people.fullname)) + 2) as name, people.*").order('name ASC')
  end

  class << self
    def next_feastday_persons
      where(feastday: where('feastday > CURRENT_DATE').order(:feastday).select('feastday').limit(1))
    end

    def send_feastday_congratulation
      people = where(feastday: Time.zone.now.to_date, active: true)
      return if people.empty?

      message = "🎉️🎉 Chúc mừng các Sơ, các Thầy và các Trưởng có bổn mạng trong ngày hôm nay (#{I18n.l(Time.zone.now.to_date, format: :default)}):\n- "
      message = message + people.map(&:fullname).map(&:upcase).join(" 🎊\n- ")
      message = message + " 🎊\nChúc các Sơ, các Thầy và các Trưởng nhiều sức khoẻ 💪 và thành công! 🏆"
      FacebookGroupsService.publish(message)
    end
  end

  def first_name
    fullname.split(' ')[-1]
  end

  private

  def strip_name
    self.fullname = self.fullname.strip
    self.christain_name = self.christain_name&.strip
    self.phone = self.phone&.strip
  end
end
