class CreateGrateful < ActiveRecord::Migration
  def self.up
    create_table :gratefuls do |t|
      t.integer :achievement_id
      t.string :grateful_1
      t.string :grateful_2
      t.string :grateful_3
      t.string :grateful_4
      t.string :grateful_5
      t.timestamps
    end
  end

  def self.down
    drop_table :gratefuls
  end
end
