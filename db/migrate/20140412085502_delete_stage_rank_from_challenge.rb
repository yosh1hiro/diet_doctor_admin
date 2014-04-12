class DeleteStageRankFromChallenge < ActiveRecord::Migration
  def change
    remove_columns :challenges, :stage, :rank
  end
end
