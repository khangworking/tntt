class CreatePeopleRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :people_relationships do |t|
      t.bigint :parent_id
      t.bigint :child_id
      t.string :relationship
      t.timestamps
    end
  end
end
