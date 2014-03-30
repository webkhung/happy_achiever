module MailerHelper

  def h1_header
    'font-size: 20px; color: darkorange;text-shadow: #ffffff 0px 1px 0px;font-weight: bold;padding-top: 10px;'
  end

  def well
    'background-color: #eeeeee;color: #000;font-size: 16px;font-style: normal;padding: 15px;margin: 0 0 0 0;line-height: 1.5em;-webkit-border-radius: 15px;-moz-border-radius: 15px;border-radius: 15px;'
  end

  def blue_link
    { style: 'color: #2028E9;' }
  end

  def blue_link_attr
    { style: 'color: #2028E9; font-weight: bold;', target: '_blank' }
  end

  def commentable_and_votable_message(commentable)
    case commentable
      when Plan then
        "your goal <b>\"#{commentable.title}\".</b>".html_safe
      when Achievement then
        achievement = commentable
        rtn = ''
        if achievement.privacy == Achievement::SHOW_TO_PUBLIC
          rtn << "you feel #{Achievement::VALID_STATE_TYPES[achievement.state_id].downcase}"
          rtn << " because #{achievement.reason}" if achievement.reason.present?
          if achievement.task.present?
            rtn << " (#{achievement.task.description})"
          end
          rtn
        else
          if achievement.task.present?
            'completed a task'
          else
            'created a state achievement'
          end
        end
    end
  end

  alias_method :commentable_message, :commentable_and_votable_message
  alias_method :votable_message, :commentable_and_votable_message
end
