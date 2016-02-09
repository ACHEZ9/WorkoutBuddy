class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :tag
      t.datetime :time
      t.string :location
      t.string :image_url

      t.timestamps null: false
    end
  end
end
