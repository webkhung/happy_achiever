class PageController < ApplicationController
  include AchievementsHelper

  def home
    if user_signed_in?
      @user = current_user

      @plans = @user.plans.order('motivation asc').all
      render 'home_logged_in'
      #if @user.achievements.empty?
      #  render 'home_logged_in'
      #else
      #  @plans = @user.plans.order('motivation asc').all
      #  render 'home_logged_in'
      #end
    else
      render 'home_not_logged_in'
    end
  end

  def how_it_works
    render 'how_it_works'
  end
end
