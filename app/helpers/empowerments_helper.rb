module EmpowermentsHelper

  def radio_list(id, choices)
    ret = ''
    choices.each do |ach|
      ret << radio_button_tag('achievement' + id, ach, false)
      ret << ach
    end
    ret.html_safe
  end

  def empowerment_text(empowerment)
    emp_sentence = (1..9).map{ |i|empowerment.send("answer_#{i}".to_sym) }.reject{ |s|s.blank? }.to_sentence
    "<u>Focus and Language:</u><br> #{emp_sentence}".html_safe if emp_sentence.present?
  end

end
