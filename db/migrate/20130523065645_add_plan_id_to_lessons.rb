class AddPlanIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :plan_id, :integer
  end
end
