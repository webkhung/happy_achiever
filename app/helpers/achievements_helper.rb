module AchievementsHelper

  def achievement_level_chart
    level_series = { name: 'Levels', data: [] }
    my_level_series = { name: 'My Levels', data: [] }

    my_level = Achievement.level

    Achievement::LEVELS.each do |level, range|
      level_series[:data] << { y: range.count, color: '#cccccc' }

      x = case
      when level < my_level[0] then range.count
      when level == my_level[0] then my_level[3] - my_level[1]
      when level > my_level[0] then 0
      end
      my_level_series[:data] << { y: x, color: '#006dcc' }

      break if level == my_level[0]
    end

    { categories: Achievement::LEVELS.keys, series: [level_series, my_level_series]}
  end

  def achievement_cumulative_chart
    days = [90,30,14,7,1]
    achievements_series = { name: 'Achievements', data: [] }
    lessons_series = { name: 'Lessons Learned', data: [] }
    days.each do |day|
      achievements_series[:data] << Achievement.count_x_days_ago(day)
      lessons_series[:data] << Lesson.count_x_days_ago(day)
    end
    {categories: days.map{|d|"#{d} days"}, series: [achievements_series, lessons_series]}
  end

  def achievements_graph_data(days = 20)
    rtn = []

    result = Achievement.all
    start_date= DateTime.now.to_date - days.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      achievements_on_date = result.select{ |a| a.achieved_date.strftime('%m/%d/%y') == temp_date.to_date.strftime('%m/%d/%y') }

      state_ids   = achievements_on_date.collect{ |a| a.state_id }.join(',')
      state_names = achievements_on_date.map{|a| Achievement::VALID_STATE_TYPES[a.state_id]}.join(',')
      image_paths = achievements_on_date.map{|a| "/assets/face#{a.state_id > 0 ? '1' : '-1'}.png" }.join(',')

      reasons = achievements_on_date.map do |a|
        task_desc = (task = a.task)? task.description : ''
        details = ''
        details << "I felt #{Achievement::VALID_STATE_TYPES[a.state_id]} #{task_desc}"
        details << " because #{a.reason}" if a.reason.present?

        if(emp = Empowerment.find_by_achievement_id(a.id))
          details << (1..9).map{|i|emp.send("answer_#{i}".to_sym)}.reject{|s|s.blank?}.join(' ')
        end
        details

      end.join('<br>')

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
