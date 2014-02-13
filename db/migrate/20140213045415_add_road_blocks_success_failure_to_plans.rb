class AddRoadBlocksSuccessFailureToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :road_block, :text
    add_column :plans, :success_definition, :text
    add_column :plans, :failure_definition, :text
  end
end
