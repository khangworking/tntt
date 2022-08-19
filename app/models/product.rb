# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(TRUE)
#  description      :text
#  name             :string
#  price            :float
#  remote_image_url :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
class Product < ApplicationRecord
  belongs_to :category
end
