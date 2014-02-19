module SchedulesHelper
  def schedules_on_date(schedules, date)
    sch = schedules.select{ |s|
      s.recurrence == Schedule::RECURRENCE_TYPES[:daily] ||
      s.recurrence == Schedule::RECURRENCE_TYPES[:weekly] && s.scheduled_date.to_date.wday == date.to_date.wday ||
      s.scheduled_date.to_date == date.to_date }

    sch.sort_by!{ |s| s.scheduled_date.strftime('%H:%M:%S') }
  end

  def combine_date_time(date_part, time_part)
    "#{date_part} #{time_part.strftime('%H:%M:%S')}"
  end

  # todo: refactor this
  def task_achieved?(achievements, task_id, date, time)
    achievements.any?{ |a| a.task_id == task_id and a.achieved_date == "#{date} #{time.strftime('%H:%M:%S')}" }
  end

  def missed_schedules(for_length = 2.weeks)
    tasks_achievement_count = {}
    tasks_scheduled_count = {}
    temp_date = for_length.ago.to_date
    end_date = Date.today

    while temp_date <= end_date
      day_schedules = schedules_on_date(Schedule.all(include: :task), temp_date)
      achievements = Achievement.achievements_on_date(temp_date.to_date)
      if day_schedules.present?
        day_schedules.each do |s|
          tasks_scheduled_count[s.task.id] = 0 unless tasks_scheduled_count[s.task.id]
          if (task_achieved?(achievements, s.task.id, temp_date, s.scheduled_date))
            tasks_achievement_count[s.task.id] = 0 unless tasks_achievement_count[s.task.id]
            tasks_achievement_count[s.task.id] += 1
          end
          tasks_scheduled_count[s.task.id] += 1
        end
      end
      temp_date += 1.day
    end

    tasks_scheduled_count.reject{ |k,_| tasks_achievement_count.keys.any?{ |kk| kk == k } }
  end

  def start_end(start_date, days, mode)
    case mode
    when :achieve
      end_date = DateTime.now.to_date
      temp_date = end_date - days.days
    when :schedule, :view
      end_date = DateTime.now.to_date + 1.day
      temp_date = DateTime.now.to_date
    when :edit
      end_date = start_date + days.days - 1.day
      temp_date = start_date
    end
    [temp_date, end_date]
  end

  def schedule_display(schedule, format)
    #{self.task.plan.title}
    case format
      when :long
        content_tag(:span, schedule.task.description) + '<br>'.html_safe +
        content_tag(:span, " #{schedule.scheduled_date.to_time.strftime('%I:%M %p')} - #{schedule.duration} mins", class: 'time')
        #"#{schedule.task.description} <span class='time'>(#{schedule.scheduled_date.to_time.strftime('%l:%M %p')} - #{schedule.duration} mins)</span>".html_safe
      when :time
        "#{schedule.task.description}<br><span class='time'>#{schedule.scheduled_date.to_time.strftime('%I:%M %p')} - #{schedule.duration} mins</span>".html_safe
    end
  end

  def schedule_day_class(day)
    classes = ''
    classes << 'today ' if day == DateTime.now.to_date
    classes << "day#{day.strftime('%u')}"
    classes
  end

  def requirement_to_schedule
    case
      when current_user.plans.empty?
        ['add a goal']
      when current_user.focus_areas.empty?
        ['add a focus area', 'add a task']
      when current_user.tasks.empty?
        ['add a task']
    end
  end
end
