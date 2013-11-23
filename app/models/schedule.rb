class Schedule < ActiveRecord::Base
  attr_accessible :task_id, :recurrence, :scheduled_date, :duration

  belongs_to :task

  RECURRENCE_TYPES = {
      daily: 1,
      weekly: 2,
      once: 3
  }
end
