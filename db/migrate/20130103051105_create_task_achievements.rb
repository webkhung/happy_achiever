class CreateTaskAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.integer :task_id
      t.integer :state_id
      t.datetime :achieved_date
      t.timestamps
    end
  end

  def self.down
    drop_table :task_achievements
  end
end
