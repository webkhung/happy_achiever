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
        text: (!viewing_self? ? '' : 'Be proud of how much you have growth!'),
        x: 0,
        y: 0,
        style: {
          color: 'SteelBlue'
        }
      )
      f.xAxis(
        categories: data[:categories]
      )
      f.plot_options(column: { grouping: false, pointWidth: 20 })
      f.legend ({ enabled: false })
      f.chart({ height: 270, marginTop: 20 })
      f.series(data[:series].first.merge(type: 'column'))
      f.series(data[:series].second.merge(type: 'column'))
      f.tooltip(enabled: false)
    end

    level_chart
  end

  def achievement_progress_chart
    days = [30,14,7,1]
    achievements_series = { name: 'Achievements', data: [] }
    lessons_series = { name: 'Lessons Learned', data: [] }
    days.each do |day|
      achievements_series[:data] << @user.achievements.achieved_before(day).count
      lessons_series[:data] << @user.lessons.count_x_days_ago(day)
    end
    data = { categories: days.map{ |d| d > 1 ? "#{d} days ago" : 'Now' }, series: [achievements_series, lessons_series] }

    accumulative_chart = LazyHighCharts::HighChart.new('graph1') do |f|
      f.subtitle(
          text: (!viewing_self? ? '' : @user.achievements.present? ? 'Be proud of how much you have achieved!' : 'Very soon you will start seeing your progress'),
          x: 0,
          y: 0,
          style: {
              color: 'SteelBlue'
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
      f.chart({ height: 300, marginTop: 20 })
      f.series(data[:series].first.merge(type: 'column'))
      f.series(data[:series].second.merge(type: 'column'))
    end

    accumulative_chart
  end

  def recent_states
    data = achievements_state_data(10)

    result = []
    data.reverse.reject{ |d| d[1][:achievement_count] == 0 }.each do |d|

      a1 = d[1][:state_names].split(',')
      a2 = d[1][:state_images].split(',')
      a3 = d[1][:reasons].split('<br>')
      a4 = d[1][:dates]

      a1.each_with_index do |_, index|
        result << { state_name: a1[index], state_image: a2[index], reason: a3[index], date: a4 }
      end
    end

    result
  end

  def display_last_state(user)
    if user.achievements.empty?
      image_tag('Happy.png')
    else
      achievement = user.achievements.last
      if show_details?(achievement)
        image_tag("#{Achievement::VALID_STATE_TYPES[achievement.state_id]}.png") + ' ' + content_tag(:span, class: 'orange') { Achievement::VALID_STATE_TYPES[achievement.state_id] }
      else
        image_tag('Happy.png')
      end
    end
  end

  def achievements_state_data(days = 10)
    data = []

    all_achievements = @user.achievements.all
    start_date= DateTime.now.to_date - days.days
    end_date = DateTime.now.to_date
    temp_date = start_date

    while temp_date <= end_date
      achievements_on_date = all_achievements.select{ |a| a.achieved_date.strftime('%m/%d/%y') == temp_date.to_date.strftime('%m/%d/%y') }

      state_ids    = achievements_on_date.collect{ |a| a.state_id }.join(',')
      state_names  = achievements_on_date.map{ |a| Achievement::VALID_STATE_TYPES[a.state_id] }.join(',')
      state_images = achievements_on_date.map{ |a| "#{Achievement::VALID_STATE_TYPES[a.state_id]}.png" }.join(',')
      image_paths  = achievements_on_date.map do |a|
        '/assets/' + (show_details?(a) ? "#{Achievement::VALID_STATE_TYPES[a.state_id]}.png" : 'Blank.png')
      end.join(',')

      reasons = achievements_on_date.map do |a|
        if show_details?(a)
          task_desc = (task = a.task)? task.description : ''
          details = ''
          details << "I felt #{Achievement::VALID_STATE_TYPES[a.state_id]} #{task_desc}".humanize
          details << " because #{a.reason} ".humanize if a.reason.present?
          if(emp = Empowerment.find_by_achievement_id(a.id))
            emp_sentence = (1..9).map{ |i|emp.send("answer_#{i}".to_sym) }.reject{ |s|s.blank? }.to_sentence
            details << "Then I learned that: #{emp_sentence}" if emp_sentence.present?
          end
          details
        else
          'Not available to view'
        end
      end.join('<br>')

      data << [temp_date.strftime('%m/%d'), {
          dates:              temp_date.to_date.strftime('%m/%d/%y'),
          achievement_count:  achievements_on_date.count,
          state_ids:          state_ids,
          state_names:        state_names,
          reasons:            reasons,
          image_paths:        image_paths,
          state_images:       state_images,
          y:                  achievements_on_date.count }]
      temp_date += 1.day
    end

    data
  end

  def achievements_state_chart(days = 10)

    data = achievements_state_data(days)

    dates = data.collect{ |a| a.first }
    values = data.collect{ |a| a.last }

    state_chart = LazyHighCharts::HighChart.new('graph') do |f|
      #f.title(
      #    text: 'What did you do that make you happy? Do more!',
      #    x: -20,
      #    style: {
      #        color: 'orange'
      #    }
      #)
      #f.subtitle(
      #    text: 'What did you focus on where you were unhappy?  Don\'t do the same thing again.',
      #    x: -20,
      #    y: 40,
      #    style: {
      #        color: 'orange'
      #    }
      #)
      f.xAxis(
          labels: { rotation: -45 },
          categories: dates
      )
      f.chart({ height: 350, marginTop: 20 })
      f.labels(items: [ html: "Total Achievements", style: {left: "0px", top: "0px", color: "black"} ])
      f.plot_options(
          series: {
              cursor: 'pointer',
              point: {
                  events: {
                      #click: %|function() {alert(this.reasons);}|.js_code,
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
                  x: -11,
                  formatter: %|column_formatter|.js_code
              }
          }
      )

      #f['plot_options'][:plot_options].delete(:series) unless viewing_self?

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

  def state_name(id)
    Achievement::VALID_STATE_TYPES[id]
  end

  def state_privacy(number)
    case number
      when Achievement::SHOW_TO_ME
        'Your response below will only be shown to you on your profile. It will not be shown to others.'
      when Achievement::SHOW_TO_FRIEND
        'Your response below will only be shown to you and your friends on your profile. It will not be shown to others.'
      when Achievement::SHOW_TO_PUBLIC
        'Your response will be shown publicly.'
    end
  end

  def show_details?(achievement)
    (viewing_profile_page? && can?(:view_on_profile, achievement)) || (!viewing_profile_page? && can?(:view, achievement))
  end

  def positive_states
    achievements = @user.achievements.where(state_id: (1..100)).order('created_at desc').all
    achievements.sample(3).map do |achievement|
      state_name  = Achievement::VALID_STATE_TYPES[achievement.state_id]
      '<p>' + "On #{achievement.created_at.strftime('%D')}, you felt #{state_name} #{(achievement.reason.present? ? "because #{achievement.reason}" : '')}</p>".humanize
    end.join('').html_safe
  end
end
