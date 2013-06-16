class AddReasonToTaskAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :reason, :string
  end
end
