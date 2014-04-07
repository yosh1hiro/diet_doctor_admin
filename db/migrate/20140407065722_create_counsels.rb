class CreateCounsels < ActiveRecord::Migration
  def change
    create_table :counsels do |t|
      #  問診票の内容
      t.string :title
      t.string :work
      t.string :meal
      t.string :exercise
      t.string :snack
      t.string :drink
      t.string :illnesses
      #  定型回答
      t.string :byProfile
      t.string :byCustom
      t.string :byAction
      t.string :byIllness
      t.string :recommendedChallenges

      t.timestamps
    end
  end
end
