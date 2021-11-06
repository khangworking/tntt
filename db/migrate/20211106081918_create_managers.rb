class CreateManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :managers do |t|
      t.belongs_to :person
      t.belongs_to :level
      t.string :role
      t.timestamps
    end
  end
end
