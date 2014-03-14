class AddIndexes < ActiveRecord::Migration
  def up
    add_index :achievements, :user_id
    add_index :empowerments, :achievement_id
    add_index :focus_areas, :plan_id
    add_index :focus_areas, :user_id
    add_index :focus_areas, :state
    add_index :gratefuls, :user_id
    add_index :gratefuls, :achievement_id
    add_index :lessons, :user_id
    add_index :milestones, :plan_id
    add_index :plans, :user_id
    add_index :plans, :state
    add_index :schedules, :user_id
    add_index :schedules, :task_id
    add_index :tasks, :user_id
    add_index :tasks, :focus_area_id
    add_index :tasks, :plan_id
    add_index :tasks, :state
    add_index :users, :state
  end

  def down
    remove_index :achievements, :user_id
    remove_index :empowerments, :achievement_id
    remove_index :focus_areas, :plan_id
    remove_index :focus_areas, :user_id
    remove_index :focus_areas, :state
    remove_index :gratefuls, :user_id
    remove_index :gratefuls, :achievement_id
    remove_index :lessons, :user_id
    remove_index :milestones, :plan_id
    remove_index :plans, :user_id
    remove_index :plans, :state
    remove_index :schedules, :user_id
    remove_index :schedules, :task_id
    remove_index :tasks, :user_id
    remove_index :tasks, :focus_area_id
    remove_index :tasks, :plan_id
    remove_index :tasks, :state
    remove_index :users, :state
  end
end
