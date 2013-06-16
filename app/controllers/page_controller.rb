class PageController < ApplicationController
  def home
    @plans = Plan.order('motivation asc').all
  end
end
