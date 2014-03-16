module PlansHelper
  def time_spent_in_words(minutes)
    Time.at(minutes * 60).utc.strftime("%Hh %Mm")
  end

  def plan_field_with_icon(icon, icon_name, field)
    rtn = ''
    rtn << icon_for(icon, icon_name)
    rtn << (field.present? ? "<span class='plan-field'>#{field}</span>" : "<span class='missing-info'>Please Enter This Field</span>")
    rtn.html_safe
  end

  def plan_field(plan, field)
    return field if field.present?
    link_to 'Please Enter This Field', edit_plan_path(plan), class: 'missing-info'
  end

  def who_has(user)
    if user == current_user
      'You have'
    else
      "#{user.display_name} Has "
    end
  end

  def plan_privacy(number)
    case
      when number == 0
        'This goal is display on your profile publicly'
      when number == 1
        'This goal\'s title, ultimate purpose, and picture are display on your profile publicly.'
      when number == 2
        'This goal\'s title and picture are display on your profile publicly.'
      when number == 3
        'This goal is show to myself only'
    end
  end

  def longest_streak(plan)
    result={}
    plan.achievements.includes(:task).reorder('task_id, achieved_date').each do |a|

      if !result.has_key?(a[:task_id])
        result[a[:task_id]] = { task:       a.task.description,
                                from_date:  a[:achieved_date].to_date,
                                to_date:    a[:achieved_date].to_date,
                                max_date:   a[:achieved_date].to_date,
                                count:      1,
                                max:        1 }
        next
      end

      if  (a[:achieved_date].to_date - result[a[:task_id]][:to_date]).to_i <= 1 # consecutive
        result[a[:task_id]][:count] += 1
        result[a[:task_id]][:to_date] = a[:achieved_date].to_date
        if result[a[:task_id]][:count] > result[a[:task_id]][:max]
          result[a[:task_id]][:max] = result[a[:task_id]][:count]
          result[a[:task_id]][:max_date] = result[a[:task_id]][:from_date]
        end
      else # another streak for the same task
        result[a[:task_id]] = { task:       a.task.description,
                                from_date:  a[:achieved_date].to_date,
                                to_date:    a[:achieved_date].to_date,
                                max_date:   result[a[:task_id]][:max_date],
                                max:        result[a[:task_id]][:max],
                                count:      1}
      end

    end

    return {} if result.empty?

    {
      longest_overall: result.max_by{ |_,v| v[:max] }[1],
      longest_current: result.select{ |_,v| v[:to_date] == Date.today || v[:to_date] == Date.yesterday }.values
    }
  end

end
