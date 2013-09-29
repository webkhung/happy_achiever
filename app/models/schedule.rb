class Schedule < ActiveRecord::Base
  attr_accessible :task_id, :recurrence, :scheduled_date, :duration

  belongs_to :task

  RECURRENCE_TYPES = {
      1 => 'Daily',
      2 => 'Weekly',
      3 => 'Once'
  }
end
