class CreateAccountables < ActiveRecord::Migration
  def up
    create_table :accountables do |t|
      t.integer :user_id, null: false
      t.text :description
      t.text :message
      t.string :frequency
      t.datetime :end_date, null: false
      t.timestamps
    end

    add_index :accountables, :user_id
  end

  def down
    drop_table :accountables
  end
end
