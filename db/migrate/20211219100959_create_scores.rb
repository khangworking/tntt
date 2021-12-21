class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.belongs_to :level
      t.date :start_date
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
