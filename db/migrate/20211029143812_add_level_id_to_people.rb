class AddLevelIdToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :level_id, :bigint
  end
end
