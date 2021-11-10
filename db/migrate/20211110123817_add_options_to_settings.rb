class AddOptionsToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :options, :text
  end
end
