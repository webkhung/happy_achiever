class RenameTaskAchievementToAchievement < ActiveRecord::Migration
  def up
    rename_table :achievements, :achievements
    rename_column :lessons, :task_achievement_id, :achievement_id
  end

  def down
    rename_table :achievements, :achievements
    rename_column :lessons, :achievement_id, :task_achievement_id
  end
end
