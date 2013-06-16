class DropActionTable < ActiveRecord::Migration
  def up
    drop_table :actions
  end

  def down
    create_table :actions
  end
end
