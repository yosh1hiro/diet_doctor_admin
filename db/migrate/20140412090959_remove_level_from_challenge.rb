class RemoveLevelFromChallenge < ActiveRecord::Migration
  def change
    remove_index :challenges, name: :index_challenges_on_group_and_level
    remove_column :challenges, :level
  end
end
