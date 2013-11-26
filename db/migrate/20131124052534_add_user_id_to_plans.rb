class AddUserIdToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :user_id, :integer
    add_column :plans, :tasks_count, :integer, default: 0
    add_column :plans, :milestones_count, :integer, default: 0

    Plan.reset_column_information
    Plan.all.each do |p|
      Plan.update_counters p.id, :tasks_count => p.tasks.length
      Plan.update_counters p.id, :milestones_count => p.milestones.length
    end
  end

  def self.down
    remove_column :plan, :user_id
    remove_column :plan, :tasks_count
    remove_column :plan, :milestones_count
  end
end
