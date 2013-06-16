class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :title
      t.string :vision
      t.string :purpose
      t.string :if_achieved
      t.string :if_not_achieved
      t.string :road_blocks
      t.string :wheel_of_life
      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
