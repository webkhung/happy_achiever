class RemoveReachedFromMilestones < ActiveRecord::Migration
  def up
    remove_column :milestones, :Reached
  end

  def down
    add_column :milestones, :Reached, :boolean
  end
end
