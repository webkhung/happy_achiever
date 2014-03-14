class PageController < ApplicationController
  include AchievementsHelper
  #include PublicActivity::Common

  def home
    if user_signed_in?
      @user = current_user
      @activities = PublicActivity::Activity.where(created_at: 5.days.ago..DateTime.now ).order('created_at desc').all
      render 'home_logged_in'
    else
      render 'home_not_logged_in'
    end
  end

  def how_it_works
    render 'how_it_works'
  end
end
