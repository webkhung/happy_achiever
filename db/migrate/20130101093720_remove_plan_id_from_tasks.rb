class RemovePlanIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :plan_id
  end

  def down
    add_column :tasks, :plan_id, :integer
  end
end
