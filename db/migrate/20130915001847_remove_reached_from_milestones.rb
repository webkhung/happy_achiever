class RemoveReachedFromMilestones < ActiveRecord::Migration
  def up
    remove_column :milestones, :reached
  end

  def down
    add_column :milestones, :reached, :boolean
  end
end
