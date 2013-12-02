class PageController < ApplicationController
  include AchievementsHelper

  def home
    if user_signed_in?
      @user = current_user

      if @user.achievements.empty?
        render 'home_first_use'
      else
        @plans = Plan.order('motivation asc').all
        render 'home_logged_in'
      end
    else
      render 'home_not_logged_in'
    end
  end
end
