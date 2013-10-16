class AddDurationToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :duration, :integer, default: 0

    Achievement.update_all('duration = 60', 'task_id is not null')
  end
end
