class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :desc
      t.date :date
      t.time :time
      t.integer :dow
      t.string :location
      t.references :sport, index: true, foreign_key: true
      t.integer :skill_level

      t.timestamps null: false
    end
  end
end
