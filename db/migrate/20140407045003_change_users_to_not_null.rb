class ChangeUsersToNotNull < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, :null => false
    change_column :users, :password, :string, :null => false
  end
end
