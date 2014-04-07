class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :user_id, :null => false
      t.integer :year, :null => false
      t.integer :month, :null => false
      t.integer :date, :null => false
      t.integer :time, :null => false

      t.float :bmi
      t.float :loss_rate
      t.integer :star_count

      t.integer :bmi_rank
      t.integer :loss_rate_rank
      t.integer :star_count_rank

      t.timestamps
    end
  end
end
