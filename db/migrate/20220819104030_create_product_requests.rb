class CreateProductRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :product_requests do |t|
      t.string :student_chirstian_name
      t.string :student_name
      t.belongs_to :level
      t.string :parent_name
      t.string :phone
      t.text :address
      t.timestamps
    end
  end
end
