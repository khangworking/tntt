# == Schema Information
#
# Table name: product_request_lines
#
#  id                 :bigint           not null, primary key
#  qty                :float
#  unit_price         :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :bigint
#  product_request_id :bigint
#
# Indexes
#
#  index_product_request_lines_on_product_id          (product_id)
#  index_product_request_lines_on_product_request_id  (product_request_id)
#
class ProductRequestLine < ApplicationRecord
  attr_accessor :checked

  belongs_to :product_request
  belongs_to :product

  before_create :set_default

  private

  def set_default
    self.qty ||= 1
    self.unit_price ||= product.price
  end
end
