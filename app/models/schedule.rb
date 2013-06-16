class Schedule < ActiveRecord::Base
  attr_accessible :task_id, :recurrence, :scheduled_date, :duration

  belongs_to :task

  RECURRENCE_TYPES = {
      1 => 'Daily',
      2 => 'Weekly',
      3 => 'Once'
  }

  def display(format)
    case format
      when :long
        "#{self.task.plan.title} -- #{self.task.description} -- #{self.scheduled_date.to_time.strftime('%l:%M %p')} (#{self.duration} mins)"
      when :short
        "#{self.task.description}"
      when :time
        "#{self.task.description} -- #{self.scheduled_date.to_time.strftime('%l:%M %p')} (#{self.duration} mins)"
    end
  end
end
