# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  birthday       :date
#  christain_name :string
#  feastday       :date
#  fullname       :string
#  gender         :string           default("male")
#  phone          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Person < ApplicationRecord
  validates :fullname, :christain_name, :birthday, :feastday, :phone, presence: true

  def first_name
    fullname.split(' ')[-1]
  end
end
