class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :desc
      t.datetime :time
      t.string :location
      t.text :image
      
      t.timestamps null: false
    end
  end
end
