class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :user_id, :null => false
      t.integer :year, :null => false
      t.integer :month, :null => false
      t.integer :date, :null => false
      t.integer :time, :null => false
      t.float :weight
      t.float :rate
      t.string :memo

      t.timestamps
    end
  end
end
