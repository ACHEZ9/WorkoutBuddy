class RemoveSportFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :sport, :string
  end
end
