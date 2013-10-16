module AchievementsHelper

  def achievements_graph_data(days = 20)
    rtn = Array.new

    result = Achievement.all
    start_date= DateTime.now.to_date - days.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      achievements_on_date = result.select{ |a| a.achieved_date.strftime('%m/%d/%y') == temp_date.to_date.strftime('%m/%d/%y') }
      #state_id    = (first = achievements_on_date.select{ |a| a.task_id.nil?}.first)? first.state_id : 0

      state_ids   = achievements_on_date.collect{ |a| a.state_id }.join(',')
      state_names = achievements_on_date.map{|a| Achievement::VALID_STATE_TYPES[a.state_id]}.join(',')
      reasons     = achievements_on_date.map do |a|
        task_desc = (task = a.task)? task.description : ''
        Achievement::VALID_STATE_TYPES[a.state_id] + '<br>' + task_desc + ' - ' + a.reason
      end.join('<br>')
      image_paths = achievements_on_date.map{|a| "/assets/face#{a.state_id > 0 ? '1' : '-1'}.png" }.join(',')

      rtn << [temp_date.strftime('%m/%d'), {
          achievement_count:  achievements_on_date.count,
          state_ids:           state_ids,
          state_names:         state_names,
          reasons:             reasons,
          image_paths:         image_paths,
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
