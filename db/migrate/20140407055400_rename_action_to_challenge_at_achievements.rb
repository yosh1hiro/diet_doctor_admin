class RenameActionToChallengeAtAchievements < ActiveRecord::Migration
  def change
    rename_column :achievements, :action_id, :challenge_id
  end
end
