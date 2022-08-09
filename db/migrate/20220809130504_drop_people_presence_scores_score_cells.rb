class DropPeoplePresenceScoresScoreCells < ActiveRecord::Migration[7.0]
  def change
    drop_table :people_presences do |t|
      t.belongs_to :user
      t.belongs_to :level
      t.text :person_ids
      t.boolean :archived, default: false
      t.timestamps
    end

    drop_table :scores do |t|
      t.belongs_to :level_id
      t.date :start_date
      t.boolean :active, default: true
      t.timestamps
    end

    drop_table :score_cells do |t|
      t.belongs_to :score
      t.belongs_to :person
      t.float :score_in_number
      t.date :applied_date
      t.bigint :modified_by
      t.string :score_type
      t.timestamps
    end
  end
end
