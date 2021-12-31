class AddArchivedToPeoplePresences < ActiveRecord::Migration[6.1]
  def change
    add_column :people_presences, :archived, :boolean, default: false
  end
end
