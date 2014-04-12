class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :group, :null => false
      t.integer :level, :null => false
      t.integer :stage, :null => false
      t.integer :rank, :null => false
      t.string :caption
      t.string :description
      t.string :comment
      t.string :category
      t.string :tips
      t.integer :star_count, null: false, default: 0
      t.integer :term, null: false, default: 0

      t.index [:group, :level], :unique => true

      t.timestamps
    end
  end
end
