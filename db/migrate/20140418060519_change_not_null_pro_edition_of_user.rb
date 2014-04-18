class ChangeNotNullProEditionOfUser < ActiveRecord::Migration
  def change
    remove_column :users, :pro_edition
    add_column :users, :pro_edition, :boolean, :null => false, :default => false
  end
end
