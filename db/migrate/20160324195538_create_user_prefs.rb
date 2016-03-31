class CreateUserPrefs < ActiveRecord::Migration
  def change
    create_table :user_prefs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sport, index: true, foreign_key: true
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
