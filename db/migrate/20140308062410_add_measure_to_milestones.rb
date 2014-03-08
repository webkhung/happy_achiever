class AddMeasureToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :measure, :string
  end
end
