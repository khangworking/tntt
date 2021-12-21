class CreateScoreCells < ActiveRecord::Migration[6.1]
  def change
    create_table :score_cells do |t|
      t.belongs_to :score
      t.belongs_to :person
      t.float :score_in_number
      t.date :applied_date
      t.bigint :modified_by
      t.timestamps
    end
  end
end
