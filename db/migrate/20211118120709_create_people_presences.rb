class CreatePeoplePresences < ActiveRecord::Migration[6.1]
  def change
    create_table :people_presences do |t|
      t.belongs_to :user
      t.belongs_to :level
      t.text :person_ids
      t.timestamps
    end
  end
end
