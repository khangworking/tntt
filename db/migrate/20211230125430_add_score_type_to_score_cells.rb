class AddScoreTypeToScoreCells < ActiveRecord::Migration[6.1]
  def change
    add_column :score_cells, :score_type, :string
  end
end
