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
end
