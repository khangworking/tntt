class RemoveEmailIndex < ActiveRecord::Migration[6.1]
  def up
    remove_index :users, :email
  end

  def down
    add_index :users, :email, unique: true
  end
end
