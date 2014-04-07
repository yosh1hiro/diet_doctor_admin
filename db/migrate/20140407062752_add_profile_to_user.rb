class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :string
    add_column :users, :occupation, :string
    add_column :users, :exercising_custom, :string
    add_column :users, :meal_custom, :string
    add_column :users, :purpose, :string

    add_column :users, :height, :float
    add_column :users, :initial_weight, :float
    add_column :users, :target_weight, :float
    add_column :users, :current_weight, :float

    add_column :users, :last_measure, :integer
    add_column :users, :loss_rate, :float
    add_column :users, :current_bmi, :float

    add_column :users, :ticket_count, :integer
    add_column :users, :star_count, :integer
    add_column :users, :medal_count, :integer

    add_column :users, :group_0, :integer
    add_column :users, :level_0, :integer
    add_column :users, :group_1, :integer
    add_column :users, :level_1, :integer
    add_column :users, :group_2, :integer
    add_column :users, :level_2, :integer
  end
end
