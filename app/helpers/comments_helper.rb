module CommentsHelper
  #def commentable_message(commentable)
  #  case commentable
  #    when Plan then
  #      "your goal <b>\"#{commentable.title}\".</b>".html_safe
  #    when Achievement then
  #      achievement = commentable
  #      rtn = ''
  #      if achievement.privacy == Achievement::SHOW_TO_PUBLIC
  #        rtn << "you feel #{Achievement::VALID_STATE_TYPES[achievement.state_id].downcase}"
  #        rtn << " because #{achievement.reason}" if achievement.reason.present?
  #        if achievement.task.present?
  #          rtn << " after completed the task: #{achievement.task.description}"
  #        end
  #        rtn
  #      else
  #        if achievement.task.present?
  #          'completed a task'
  #        else
  #          'created a state achievement'
  #        end
  #      end
  #  end
  #end
end
