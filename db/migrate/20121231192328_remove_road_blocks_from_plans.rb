class RemoveRoadBlocksFromPlans < ActiveRecord::Migration
  def up
    remove_column :plans, :road_blocks
  end

  def down
    add_column :plans, :road_blocks, :string
  end
end
