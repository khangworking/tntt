class AddProductNameToProductRequestLines < ActiveRecord::Migration[7.0]
  def change
    add_column :product_request_lines, :product_name, :string
  end
end
