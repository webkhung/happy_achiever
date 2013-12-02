class AddUserIdToMoreTables < ActiveRecord::Migration
  def change
    add_column :tasks, :user_id, :integer
    add_column :schedules, :user_id, :integer

    Task.update_all('user_id = 1')
    Schedule.update_all('user_id = 1')
  end
end
