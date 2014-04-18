class AddInitialBmiToUser < ActiveRecord::Migration
  def change
    add_column :users, :initial_bmi, :float
  end
end
