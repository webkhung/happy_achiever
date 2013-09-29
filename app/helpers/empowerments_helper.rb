module EmpowermentsHelper

  def radio_list(id, choices)
    ret = ''
    choices.each do |ach|
      ret << radio_button_tag('achievement' + id, ach, false)
      ret << ach
    end
    ret.html_safe
  end
end
