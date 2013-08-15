class PageController < ApplicationController
  def home
    @plans = Plan.order('motivation asc').all

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Combination chart"})
      f.options[:xAxis][:categories] = ['jan 1', 'jan 2', 'jan 3', 'jan 4', 'jan 5']
      f.labels(:items=>[:html=>"Total Achievement", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'column',:name=> 'achievement',:data=> [3,4,5,6])
    end
  end
end
