# == Schema Information
#
# Table name: product_request_lines
#
#  id                 :bigint           not null, primary key
#  product_name       :string
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

  before_validation :set_default

  validates :qty, :unit_price, presence: true

  private

  def set_default
    self.qty ||= 1
    self.unit_price ||= product.price
    self.product_name ||= product.name.presence || "Product ID(#{product.id})"
  end
end
