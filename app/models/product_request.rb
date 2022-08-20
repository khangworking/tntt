# == Schema Information
#
# Table name: product_requests
#
#  id                     :bigint           not null, primary key
#  address                :text
#  parent_name            :string
#  phone                  :string
#  status                 :string
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

  enum status: {
    created: 'created',
    confirmed: 'confirmed',
    cancelled: 'cancelled',
    completed: 'completed'
  }

  def to_product_names(locale = :vi)
    product_request_lines.map do |line|
      "#{line.product_name} (#{I18n.t('common.counting', count: line.qty.to_i)})"
    end.join(', ')
  end

  def total
    product_request_lines.sum(&:unit_price)
  end

  private

  def unchecked?(attr)
    attr[:checked].blank? || attr[:checked].in?([0, '0', false])
  end
end
