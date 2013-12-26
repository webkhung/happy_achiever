class AddReasonToTaskAchievements < ActiveRecord::Migration
  def change
    add_column :task_achievements, :reason, :string
  end
end
