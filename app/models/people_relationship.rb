# == Schema Information
#
# Table name: people_relationships
#
#  id           :bigint           not null, primary key
#  relationship :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  child_id     :bigint
#  parent_id    :bigint
#
class PeopleRelationship < ApplicationRecord
  belongs_to :parent, class_name: Person.to_s
  belongs_to :child, class_name: Person.to_s

  enum relationship: {
    grandfather: 'grandfather',
    grandmother: 'grandmother',
    father: 'father',
    mother: 'mother',
    sister: 'sister',
    brother: 'brother',
    other: 'other'
  }

  validates :relationship, presence: true
  validates_uniqueness_of :relationship, scope: :child_id
end
