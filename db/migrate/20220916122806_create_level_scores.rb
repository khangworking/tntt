class CreateLevelScores < ActiveRecord::Migration[7.0]
  def change
    create_table :level_scores do |t|
      t.float :score_number, default: 0
      t.text :note
      t.belongs_to :person
      t.string :date_chain
      t.belongs_to :level
      t.string :score_type
      t.timestamps
    end
  end
end
