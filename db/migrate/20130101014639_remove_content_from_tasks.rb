class RemoveContentFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :content

    add_column :tasks, :title, :string
    add_column :tasks, :description, :string
    add_column :tasks, :purpose, :string
    add_column :tasks, :focus_area_id, :integer
  end

  def down
    add_column :tasks, :content, :string

    remove_column :tasks, :title
    remove_column :tasks, :description
    remove_column :tasks, :purpose
    remove_column :tasks, :focus_area_id
  end
end
