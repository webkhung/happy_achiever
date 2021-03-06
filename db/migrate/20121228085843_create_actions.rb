class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.string :title
      t.string :description
      t.string :purpose
      t.integer :focus_area_id
      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
