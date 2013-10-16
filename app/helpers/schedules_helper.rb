module SchedulesHelper
  def schedules_on_date(schedules, date)
    sch = schedules.select{ |s|
      s.recurrence == Schedule::RECURRENCE_TYPES.key('Daily') || 
      s.recurrence == Schedule::RECURRENCE_TYPES.key('Weekly') && s.scheduled_date.to_date.wday == date.to_date.wday ||
      s.scheduled_date.to_date == date.to_date }

    sch.sort_by!{ |s| s.scheduled_date.strftime('%H:%M:%S') }
  end

  def combine_date_time(date_part, time_part)
    "#{date_part} #{time_part.strftime('%H:%M:%S')}"
  end

  def task_achieved?(achievements, task_id, date, time)
    achievements.select{ |a| a.task_id == task_id and a.achieved_date == "#{date} #{time.strftime('%H:%M:%S')}" }.present?
  end

  def start_end(start_date, days, mode)
    case mode
    when 'achieve'
      end_date = DateTime.now.to_date
      temp_date = end_date - days.days
    when 'schedule', 'view'
      end_date = DateTime.now.to_date + 1.day
      temp_date = DateTime.now.to_date
    when 'edit'
      end_date = start_date + days.days - 1.day
      temp_date = start_date
    end
    [temp_date, end_date]
  end

  def schedule_display(schedule, format)
    #{self.task.plan.title}
    case format
      when :long
        content_tag(:span, schedule.task.description) +
        content_tag(:span, " (#{schedule.scheduled_date.to_time.strftime('%l:%M %p')} - #{schedule.duration} mins)", class: 'time')
        #"#{schedule.task.description} <span class='time'>(#{schedule.scheduled_date.to_time.strftime('%l:%M %p')} - #{schedule.duration} mins)</span>".html_safe
      when :short
        "#{schedule.task.description}"
      when :time
        "#{schedule.task.description} <span class='time'>(#{schedule.scheduled_date.to_time.strftime('%l:%M %p')} - #{schedule.duration} mins)</span>".html_safe
    end
  end

  def schedule_day_class(day)
    classes = ''
    classes << 'today ' if day == DateTime.now.to_date
    classes << "day#{day.strftime('%u')}"
    classes
  end
end
