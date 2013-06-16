class RemoveDescriptionFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :description
  end

  def down
    add_column :tasks, :description, :string
  end
end
