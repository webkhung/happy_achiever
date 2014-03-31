class AddOrderColumns < ActiveRecord::Migration
  def change
    add_column :plans, :display_order, :integer, default: 1
    add_column :tasks, :display_order, :integer, default: 1
    add_column :focus_areas, :display_order, :integer, default: 1
  end
end
