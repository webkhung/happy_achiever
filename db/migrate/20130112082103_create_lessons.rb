class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.string :category
      t.string :note
      t.references :learnable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
