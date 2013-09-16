class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.integer :plan_id
      t.datetime :target
      t.boolean :reached, default: false
      t.timestamps
    end
  end

  def self.down
    drop_table :milestones
  end
end
