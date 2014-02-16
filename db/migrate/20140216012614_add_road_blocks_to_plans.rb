class AddRoadBlocksToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :road_block_1, :text
    add_column :plans, :road_block_2, :text
    add_column :plans, :road_block_3, :text
  end
end
