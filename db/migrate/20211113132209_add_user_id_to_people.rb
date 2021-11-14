class AddUserIdToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :user_id, :bigint
    add_index :people, :user_id
  end
end
