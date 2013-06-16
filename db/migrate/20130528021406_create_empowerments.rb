class CreateEmpowerments < ActiveRecord::Migration
  def self.up
    create_table :empowerments do |t|
      t.integer :achievement_id
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_4
      t.string :answer_5
      t.string :answer_6
      t.string :answer_7
      t.timestamps
    end
  end

  def self.down
    drop_table :empowerments
  end
end
