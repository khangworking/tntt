class CreateProductRequestLines < ActiveRecord::Migration[7.0]
  def change
    create_table :product_request_lines do |t|
      t.belongs_to :product
      t.float :qty
      t.float :unit_price
      t.belongs_to :product_request
      t.timestamps
    end
  end
end
