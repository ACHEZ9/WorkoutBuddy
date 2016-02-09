class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :tag
      t.string :text
      t.string :time
      t.string :datetime
      t.string :location
      t.string :string
      t.string :image_url
      t.string :string

      t.timestamps null: false
    end
  end
end
