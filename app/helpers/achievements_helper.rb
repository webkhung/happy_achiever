module AchievementsHelper
  def last_achieved(plan)
    latest_achievement = Achievement.latest_achievement_in_plan(plan.id)
    if latest_achievement.nil?
      "NONE!"
    else
      if latest_achievement.achieved_date < 4.day.ago
        content_tag(:span, "You haven't done anything in this goal for too long.  You should add a schedule or do a task right now", :class=>'label label-important')
      else
        icon_for(:trophy, "Last achievement: #{latest_achievement.task.description} on  #{latest_achievement.achieved_date.strftime("%c  ")}") +
        content_tag(:span, 'Good Job!', :class => 'label label-success')
      end
    end
  end

  def achievement_count()
    rtn = Array.new

#    result = Achievement.where('task_id is not null').count(:group => 'date(achieved_date)')
    result = Achievement.count(:group => 'date(achieved_date)')
    start_date= DateTime.now.to_date - 10.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      a = result.find { |dt, _| dt == temp_date.to_date }
      rtn << (a.present? ? "#{a[0]} #{highlight(a[1])}".html_safe : "#{temp_date} #{highlight(0)}".html_safe)
      temp_date += 1.day
    end

    rtn
  end

  def highlight(number)
    case
      when number == 0
        "<span class='badge badge-default'>#{number}</span>"
      when number == 1
        "<span class='badge badge-success'>#{number}</span>"
      when number >= 2
        "<span class='badge badge-warning'>#{number}</span>"
    end
  end
end
