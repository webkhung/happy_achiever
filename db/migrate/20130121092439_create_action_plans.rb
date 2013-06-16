class CreateActionPlans < ActiveRecord::Migration
  def self.up
    create_table :action_plans do |t|
      t.integer :task_id
      t.integer :occurrence
      t.integer :target_count
      t.datetime :start_date
      t.timestamps
    end
  end

  def self.down
    drop_table :action_plans
  end
end
