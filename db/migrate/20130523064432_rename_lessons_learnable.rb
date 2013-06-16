class RenameLessonsLearnable < ActiveRecord::Migration
  def up
    remove_column :lessons, :learnable_type
    rename_column :lessons, :learnable_id, :task_achievement_id
  end

  def down
    add_column :lessons, :learnable_type, :integer
    rename_column :lessons, :task_achievement_id, :learnable_id
  end
end
