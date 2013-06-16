class DropStateAchievements < ActiveRecord::Migration
  def up
    drop_table :state_achievements
  end

  def down
    create_table :state_achievements
  end
end
