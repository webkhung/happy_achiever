class PageController < ApplicationController
  include AchievementsHelper

  def home
    @plans = Plan.order('motivation asc').all

    #dates = achievement_count(false, 10).map do |a|
    #  a.first.strftime('%m/%d')
    #end
    #
    #values = achievement_count(false, 10).map(&:last)

    data = achievements_graph_data(10)
    dates = data.collect{ |a| a.first }
    values = data.collect{ |a| a.last }

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
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
          color: '#fbb450',
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

    puts values
  end
end


