# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true

  after_create :set_slug

  private

  def set_slug
    update(slug: "#{name.parameterize}-#{id}")
  end
end
