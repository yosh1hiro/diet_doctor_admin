class AddImageToChallengeAndLevel < ActiveRecord::Migration
  def change
    add_column :challenges, :image, :binary
    add_column :levels, :image, :binary
  end
end
