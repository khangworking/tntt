# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Setting < ApplicationRecord
  def self.value_of(name)
    find_by(name: name)&.value
  end
end
