class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :fullname
      t.string :christain_name
      t.string :phone
      t.date :birthday
      t.date :feastday

      t.timestamps
    end
  end
end
