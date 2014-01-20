class Schedule < ActiveRecord::Base
  attr_accessible :task_id, :recurrence, :scheduled_date, :duration

  belongs_to :task
  belongs_to :user

  validates_presence_of :task_id, :recurrence, :scheduled_date, :duration

  RECURRENCE_TYPES = {
      daily: 1,
      weekly: 2,
      once: 3
  }
end
