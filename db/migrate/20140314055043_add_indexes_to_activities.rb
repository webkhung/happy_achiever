class AddIndexesToActivities < ActiveRecord::Migration
  def change
    add_index :activities, :created_at
  end
end
