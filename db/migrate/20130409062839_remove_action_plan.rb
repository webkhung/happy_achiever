class RemoveActionPlan < ActiveRecord::Migration
  def up
    drop_table :action_plans

    remove_column :schedules, :action_plan_id
    add_column :schedules, :duration, :integer
  end

  def down
    create_table :action_plans do |t|
      t.integer :task_id
      t.integer :occurrence
      t.integer :target_count
      t.datetime :start_date
      t.timestamps
    end

    add_column :schedules, :action_plan_id, :integer
    remove_column :schedules, :duration
  end
end
