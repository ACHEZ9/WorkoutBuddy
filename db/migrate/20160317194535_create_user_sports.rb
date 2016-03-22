class CreateUserSports < ActiveRecord::Migration
  def change
    create_table :user_sports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sport, index: true, foreign_key: true
      t.integer :skill
      t.integer :games

      t.timestamps null: false
    end
  end
end
