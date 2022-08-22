# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  all_day        :boolean          default(TRUE)
#  description    :text
#  end_datetime   :datetime
#  start_datetime :datetime
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Event < ApplicationRecord
  validates :title, :start_datetime, presence: true
end
