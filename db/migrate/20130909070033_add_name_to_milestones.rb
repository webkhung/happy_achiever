class AddNameToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :name, :string
  end
end
