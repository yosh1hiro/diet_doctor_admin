class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :occur, null: false
      t.integer :user_id, null: false
      t.integer :event_code, null: false
      t.integer :value

      t.timestamps
    end
  end
end
