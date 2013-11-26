class PageController < ApplicationController
  include AchievementsHelper

  def home

    if user_signed_in?
      @user = current_user
      @plans = Plan.order('motivation asc').all
      render 'home_logged_in'
    else
      render 'home_not_logged_in'
    end
  end
end
