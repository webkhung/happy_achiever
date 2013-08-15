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

  def achieve_action(task_id, date, time)

    achievements = Achievement.achievements_on_date(date)

    if task_achieved?(achievements, task_id, date, time)
      'Achieved!'
    else
      link_to 'Achieve', new_task_achievement_path(task_id, :date => combine_date_time(date, time))
    end
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
      end_date = start_date + days.days
      temp_date = start_date
    end
    [temp_date, end_date]
  end

  def task_format(mode, date, schedule)
    ret = ''
    ret << image_tag(schedule.task.plan.image_url, :class => 'img-polaroid schedule-thumb plan-small' )
    case mode
      when 'view'
        ret << content_tag(:div, :class => 'schedule-text') { schedule.display(:time) }
      when 'schedule', 'edit'
        ret << content_tag(:div, :class => 'schedule-text') { schedule.display(:long) }
        ret << link_to('edit', edit_schedule_path(schedule))
        ret << link_to('x', schedule, :confirm => 'Are you sure?', :method => :delete)
        if date <= DateTime.now.to_date
          ret << achieve_action(schedule.task.id, date, schedule.scheduled_date)
        end
      when 'achieve'
        ret << content_tag(:div, :class => 'schedule-text') { schedule.display(:short) }
        if date <= DateTime.now.to_date
          ret << achieve_action(schedule.task.id, date, schedule.scheduled_date)
        end
    end
    ret.html_safe
  end
end
