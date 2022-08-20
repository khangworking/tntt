class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :remote_image_url
      t.float :price
      t.boolean :active, default: true
      t.bigint :category_id, index: true
      t.timestamps
    end
  end
end
