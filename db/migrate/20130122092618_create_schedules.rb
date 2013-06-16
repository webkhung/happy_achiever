class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.integer :task_id
      t.integer :action_plan_id
      t.datetime :scheduled_date
      t.boolean :recurrence, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
