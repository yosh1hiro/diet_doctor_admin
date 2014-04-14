class DeleteCategoryAndRenameStarToLevel < ActiveRecord::Migration
  def change
    remove_column :levels, :category
    rename_column :levels, :star_count, :star
  end
end
