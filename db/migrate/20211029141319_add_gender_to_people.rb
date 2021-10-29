class AddGenderToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :gender, :string, default: 'male'
  end
end
