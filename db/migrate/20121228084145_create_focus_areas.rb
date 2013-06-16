class CreateFocusAreas < ActiveRecord::Migration
  def self.up
    create_table :focus_areas do |t|
      t.string :title
      t.integer :plan_id
      t.timestamps
    end
  end

  def self.down
    drop_table :focus_areas
  end
end
