class AddUserIdToMoreTables2 < ActiveRecord::Migration
  def change
    add_column :focus_areas, :user_id, :integer

    FocusArea.update_all('user_id = 1')
  end
end
