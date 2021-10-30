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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  level_id       :bigint
#
class Person < ApplicationRecord
  validates :fullname, :christain_name, :birthday, :feastday, :phone, presence: true

  belongs_to :level

  before_validation :strip_name

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
