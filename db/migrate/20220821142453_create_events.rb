class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.boolean :all_day, default: true
      t.text :description

      t.timestamps
    end
  end
end
