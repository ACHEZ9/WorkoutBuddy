class DropSports < ActiveRecord::Migration
  def up
    drop_table :sports
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
