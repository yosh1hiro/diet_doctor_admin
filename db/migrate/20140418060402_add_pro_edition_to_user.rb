class AddProEditionToUser < ActiveRecord::Migration
  def change
    add_column :users, :pro_edition, :boolean
  end
end
