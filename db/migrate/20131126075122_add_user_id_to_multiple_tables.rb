class AddUserIdToMultipleTables < ActiveRecord::Migration
  def change
    add_column :achievements, :user_id, :integer
    add_column :gratefuls, :user_id, :integer
    add_column :lessons, :user_id, :integer

    Achievement.update_all('user_id = 1')
    Grateful.update_all('user_id = 1')
    Lesson.update_all('user_id = 1')
  end
end
