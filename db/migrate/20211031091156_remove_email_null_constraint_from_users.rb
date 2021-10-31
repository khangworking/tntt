class RemoveEmailNullConstraintFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :email, :string, :null => true
    change_column :users, :phone, :string, :null => false
  end
end
