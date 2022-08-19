# == Schema Information
#
# Table name: product_requests
#
#  id                     :bigint           not null, primary key
#  address                :text
#  parent_name            :string
#  phone                  :string
#  student_chirstian_name :string
#  student_name           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  level_id               :bigint
#
# Indexes
#
#  index_product_requests_on_level_id  (level_id)
#
class ProductRequest < ApplicationRecord
  has_many :product_request_lines

  validates :parent_name, :phone, presence: true

  accepts_nested_attributes_for :product_request_lines, reject_if: :unchecked?

  private

  def unchecked?(attr)
    attr[:checked].blank? || attr[:checked].in?([0, '0', false])
  end
end
