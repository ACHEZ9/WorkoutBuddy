class AddSkillLevelToEvents < ActiveRecord::Migration
  def change
    add_column :events, :skill_level, :integer
  end
end
