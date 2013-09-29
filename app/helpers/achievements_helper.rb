module AchievementsHelper
  def last_achieved(plan)
    latest_achievement = Achievement.latest_achievement_in_plan(plan.id)
    if latest_achievement.nil?
      "You haven't done anything for this goal yet!"
    else
      if latest_achievement.achieved_date < 4.day.ago
        content_tag(:div, :class=>'alert alert-block alert-error fade in') do
          content_tag(:h4, 'Oh Snap!', class: 'alert-heading') +
          content_tag(:p, "You haven't done anything in this goal for too long.  Usually it is because the WHY is not big enough.  WHY do you want to achieve this goal?  What will you get if you achieve?  How will your life change if you achieve it?<br>What happen if you cannot achieve?  What will you lose and miss?<br>Imagine what you future will be and revise your WHY".html_safe) +
          link_to('Change Your Why', edit_plan_path(plan), class: 'btn btn-danger')
        end
      else
        icon_for(:trophy, "Last achievement: #{latest_achievement.task.description} on  #{latest_achievement.achieved_date.strftime("%c  ")}") +
        content_tag(:span, 'Good Job!', :class => 'label label-success')
      end
    end
  end

  def achievement_count(html = false, days = 20)
    rtn = Array.new

    # result = Achievement.where('task_id is not null').count(:group => 'date(achieved_date)')
    result = Achievement.count(:group => 'date(achieved_date)')
    start_date= DateTime.now.to_date - days.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      a = result.find { |dt, _| dt == temp_date.to_date }
      if html
        rtn << (a.present? ? "#{a[0]} #{highlight(a[1])}".html_safe : "#{temp_date} #{highlight(0)}".html_safe)
      else
        rtn << (a.present? ? a : [temp_date, 0])
      end
      temp_date += 1.day
    end

    rtn
  end

  def achievements_graph_data(days = 20)
    rtn = Array.new

    result = Achievement.all
    start_date= DateTime.now.to_date - days.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      achievements_on_date = result.select{ |a| a.achieved_date.strftime('%m/%d/%y') == temp_date.to_date.strftime('%m/%d/%y') }
      state_id = (first = achievements_on_date.select{ |a| a.task_id.nil?}.first)? first.state_id : 0
      rtn << [temp_date.strftime('%m/%d'), {
          achievement_count:  achievements_on_date.count,
          state_id:           state_id,
          state_name:         (Achievement::VALID_STATE_TYPES[state_id] if state_id != 0) || '',
          reason:             (first = achievements_on_date.select{ |a| a.task_id.nil?}.first)? first.reason : 0,
          image_path:         ("/assets/face#{state_id > 0 ? '1' : '-1'}.png" if state_id != 0) || '',
          y:                  achievements_on_date.count }]
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
