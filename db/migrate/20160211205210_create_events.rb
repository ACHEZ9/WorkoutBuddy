class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :desc
      t.date :date
      t.time :time
      t.integer :dow
      t.string :location
      t.text :image
      t.references :sport, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
