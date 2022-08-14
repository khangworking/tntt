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

class Person < ApplicationRecord
  validates :fullname, presence: true
  validates_uniqueness_of :phone, allow_blank: true

  belongs_to :level, optional: true
  belongs_to :user, optional: true, dependent: :destroy
  has_many :manage_levels, class_name: Manager.to_s, dependent: :destroy
  has_many :parent_relationships, foreign_key: :child_id, class_name: PeopleRelationship.to_s
  has_many :parents, through: :parent_relationships, source: :parent
  has_many :child_relationships, foreign_key: :parent_id, class_name: PeopleRelationship.to_s
  has_many :children, through: :child_relationships, source: :child

  before_validation :strip_name

  enum gender: { male: 'male', female: 'female' }
  enum role: { leader: 'leader', vice_leader: 'vice_leader' }

  scope :students, -> do
    joins(:level).where(levels: { name: Level::STUDENT_NAMES })
  end
  scope :leaders, -> do
    joins(:level).where(levels: { name: Level::LEADER_NAMES })
  end
  scope :order_name_alphabel, -> do
    select("substring(people.fullname, length(people.fullname) - position(' ' in reverse(people.fullname)) + 2) as name, people.*").order('name ASC')
  end
  scope :active, -> { where(active: true) }

  class << self
    def next_feastday_persons(num = 1)
      feastday_query =
        where('feastday > CURRENT_DATE')
        .where(active: true)
        .order(:feastday)
        .select('feastday')
        .distinct
        .limit(num)
      where(feastday: feastday_query)
        .joins(:level)
        .where(levels: { name: Level::LEADER_NAMES + %w[tro_uy tro_ta] })
        .where(active: true)
        .order(:feastday)
        .group_by(&:feastday)
    end

    def new_parent(params, child_id:, relationship: :other)
      transaction do
        phone = params[:phone]
        parent = find_by(phone: phone) if phone.present?
        parent ||= create!(params)
        PeopleRelationship.create!(parent: parent, child_id: child_id, relationship: relationship)
      end
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback
    end

    def students_to_csv
      require "csv"
      CSV.generate(encoding: 'utf-8') do |csv|
        eager_load(:level).where(levels: { name: Level::STUDENT_NAMES }).each do |ps|
          csv << [ps.christain_name, ps.fullname, I18n.t("common.#{ps.level.name}")]
        end
      end
    end

    def to_csv(mapped_columns, scope)
      require 'csv'
      head = %w[EF BB BF].map { |a| a.hex.chr }.join
      CSV.generate(csv = head) do |csv|
        csv << ['STT'] + mapped_columns.values
        scope.includes(:level).each_with_index do |ps, index|
          csv << [index + 1] + mapped_columns.keys.map do |attr|
            ps.public_send(attr)
          end
        end
      end
    end
  end

  def first_name
    fullname.split(' ')[-1]
  end

  def name_for_short
    fullname.split(' ')[0..-2].map do |letter|
      "#{letter.first}."
    end.join('') + first_name
  end

  def level_name
    level&.name.presence && I18n.t("common.#{level.name}")
  end

  def localed_gender
    I18n.t("common.#{gender}")
  end

  private

  def strip_name
    self.fullname = self.fullname.strip
    self.christain_name = self.christain_name&.strip
    self.phone = self.phone&.strip
  end
end
