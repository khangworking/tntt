class AddSortOrderToLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :levels, :sort_order, :float
  end
end
