class AddChallengeIdToLevel < ActiveRecord::Migration
  def change
    add_column :levels, :challenge_id, :integer
  end
end
