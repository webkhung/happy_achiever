class CreateStateAchievements < ActiveRecord::Migration
  def self.up
    create_table :state_achievements do |t|
      t.integer :state_id
      t.string :note
      t.timestamps
    end
  end

  def self.down
    drop_table :state_achievements
  end
end
