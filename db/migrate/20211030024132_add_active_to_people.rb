class AddActiveToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :active, :boolean, default: true
  end
end
