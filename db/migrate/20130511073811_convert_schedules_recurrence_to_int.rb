class ConvertSchedulesRecurrenceToInt < ActiveRecord::Migration
  def up
    remove_column :schedules, :recurrence
    add_column :schedules, :recurrence, :integer
  end

  def down
    remove_column :schedules, :recurrence
    add_column :schedules, :recurrence, :tinyint
  end
end
