class AddDefaultStageRankValueToLevel < ActiveRecord::Migration
  def change
    change_column_default(:levels, :stage, 0)
    change_column_default(:levels, :rank, 0)
  end
end
