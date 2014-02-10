class AddPlanIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :plan_id, :integer

    #FocusArea.all.each do |fa|
    #  fa.tasks.each do |t|
    #    t.update_column(:plan_id, fa.plan_id)
    #  end
    #end
  end
end
