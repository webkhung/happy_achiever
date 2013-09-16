class PageController < ApplicationController
  include AchievementsHelper

  def home
    @plans = Plan.order('motivation asc').all

    dates = achievement_count(false, 10).map do |a|
      a.first.strftime('%m/%d')
    end

    values = achievement_count(false, 10).map(&:last)

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      #f.title({ :text=>"Combination chart"})
      #f.options[:xAxis][:categories] = dates
      f.xAxis(
        labels: { :rotation => -45 },
        categories: dates
      )
      f.labels(items: [ html: "Total Achievements", style: {left: "0px", top: "0px", color: "black"} ])
      f.series(type: 'column', name: 'achievement', data: values)
    end
  end
end
