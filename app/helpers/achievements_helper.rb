module AchievementsHelper

  def achievement_level_chart
    level_series = { name: 'Levels', data: [] }
    my_level_series = { name: 'My Levels', data: [] }

    my_level = @user.level

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

    data = { categories: Achievement::LEVELS.keys, series: [level_series, my_level_series]}

    level_chart = LazyHighCharts::HighChart.new('graph3') do |f|
      f.subtitle(
          text: 'Be proud of how much you have growth!',
          x: 0,
          y: 0,
          style: {
              color: 'orange'
          }
      )
      f.xAxis(
          categories: data[:categories]
      )
      f.plot_options(column: { grouping: false })
      f.legend ({ enabled: false })
      f.chart({ height: 250, marginTop: 20 })
      f.series(data[:series].first.merge(type: 'column'))
      f.series(data[:series].second.merge(type: 'column'))
    end

    level_chart
  end

  def achievement_cumulative_chart
    days = [90,30,14,7,1]
    achievements_series = { name: 'Achievements', data: [] }
    lessons_series = { name: 'Lessons Learned', data: [] }
    days.each do |day|
      achievements_series[:data] << @user.achievements.achieved_before(day).count
      lessons_series[:data] << Lesson.count_x_days_ago(day)
    end
    data = {categories: days.map{|d|"#{d} days"}, series: [achievements_series, lessons_series]}

    accumulative_chart = LazyHighCharts::HighChart.new('graph1') do |f|
      f.subtitle(
          text: 'Be proud of how much you have achieved!',
          x: 0,
          y: 0,
          style: {
              color: 'orange'
          }
      )
      f.xAxis(
          categories: data[:categories]
      )
      f.plot_options(
          column: {
              stacking: 'normal'
          }
      )
      f.chart({ height: 280, marginTop: 20 })
      f.series(data[:series].first.merge(type: 'column'))
      f.series(data[:series].second.merge(type: 'column'))
    end

    accumulative_chart
  end

  def achievements_chart(days = 20)
    data = []

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

      data << [temp_date.strftime('%m/%d'), {
          achievement_count:  achievements_on_date.count,
          state_ids:           state_ids,
          state_names:         state_names,
          reasons:             reasons,
          image_paths:         image_paths,
          y:                  achievements_on_date.count }]
      temp_date += 1.day
    end

    dates = data.collect{ |a| a.first }
    values = data.collect{ |a| a.last }

    state_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(
          text: 'What did you do that make you happy? Do more!',
          x: -20,
          style: {
              color: 'orange'
          }
      )
      f.subtitle(
          text: 'What did you focus on where you were unhappy?  Don\'t do the same thing again.',
          x: -20,
          y: 40,
          style: {
              color: 'orange'
          }
      )
      f.xAxis(
          labels: { rotation: -45 },
          categories: dates
      )
      f.labels(items: [ html: "Total Achievements", style: {left: "0px", top: "0px", color: "black"} ])
      f.plot_options(
          series: {
              cursor: 'pointer',
              point: {
                  events: {
                      click: %|function() {alert(this.reasons);}|.js_code,
                      mouseOver: %|chart_mouse_over|.js_code,
                      mouseOut: %|chart_mouse_out|.js_code

                  }
              },
              events: {
                  mouseOut: %|chart_mouse_out|.js_code
              }
          },
          column: {
              color: '#f6a828',
              dataLabels: {
                  enabled: true,
                  useHTML: true,
                  verticalAlign: 'top',
                  y: 0,
                  formatter: %|column_formatter|.js_code
              }
          }
      )
      f.series(type: 'column', name: 'achievement', data: values)
      f.tooltip(
          enabled: false,
          borderRadius: 0,
          shadow: false,
          shared: true,
          useHTML: true,
          pointFormat: '{series.name} {point.y}'
      )
    end

    state_chart
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

  def level(achievement_count)
    level = Achievement::LEVELS.select{ |_, range| range.cover? achievement_count }.first
    [level[0], level[1].first, level[1].last, achievement_count]
  end
end
