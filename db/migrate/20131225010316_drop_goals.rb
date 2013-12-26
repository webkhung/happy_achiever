class DropGoals < ActiveRecord::Migration
  def up
    drop_table :goals
  end

  def down
    create_table :goals do |t|
      t.string :content
      t.integer :plan_id
      t.timestamps
    end
  end
end
