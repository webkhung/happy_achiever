class RenameTasksTitleToDescription < ActiveRecord::Migration
  def up
    rename_column :tasks, :title, :description
  end

  def down
    rename_column :tasks, :description, :title
  end
end
