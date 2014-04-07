class CreateCounselComments < ActiveRecord::Migration
  def change
    create_table :counsel_comments do |t|
      t.integer :counsel_id
      t.integer :user_id
      t.integer :time
      t.string  :comment

      t.timestamps
    end
  end
end

