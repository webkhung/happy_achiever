class AddStatusToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :status, :integer, :default => 0
  end
end
