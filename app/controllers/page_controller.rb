class PageController < ApplicationController
  include AchievementsHelper

  def home
    @plans = Plan.order('motivation asc').all

    data = achievements_graph_data(20)
    dates = data.collect{ |a| a.first }
    values = data.collect{ |a| a.last }

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
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


    chart_data = achievement_cumulative_chart
    @chart2 = LazyHighCharts::HighChart.new('graph1') do |f|
      f.xAxis(
          categories: chart_data[:categories]
      )
      f.plot_options(
        column: {
          stacking: 'normal'
        }
      )
      f.chart({ height: 300 })
      f.series(chart_data[:series].first.merge(type: 'column'))
      f.series(chart_data[:series].second.merge(type: 'column'))
    end

    level_chart_data = achievement_level_chart
    @chart3 = LazyHighCharts::HighChart.new('graph3') do |f|
      f.xAxis(
          categories: level_chart_data[:categories]
      )
      f.plot_options(column: { grouping: false })
      f.legend ({ enabled: false })
      f.chart({ height: 250 })
      f.series(level_chart_data[:series].first.merge(type: 'column'))
      f.series(level_chart_data[:series].second.merge(type: 'column'))
    end
  end
end
