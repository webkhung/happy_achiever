module PlansHelper
  def time_spent_in_words(minutes)
    Time.at(minutes * 60).utc.strftime("%Hh %Mm")
  end

  def plan_field_with_icon(icon, icon_name, field)
    rtn = ''
    rtn << icon_for(icon, icon_name)
    rtn << (field.present? ? field : "<span class='missing-info'>Please Enter This Field</span>")
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

end
