class IncreaseTextColumnSize < ActiveRecord::Migration
  def up
    change_column :plans, :vision, :text
    change_column :plans, :purpose, :text
    change_column :plans, :if_achieved, :text
    change_column :plans, :if_not_achieved, :text
    change_column :plans, :motivation, :text
  end

  def down
  end
end
