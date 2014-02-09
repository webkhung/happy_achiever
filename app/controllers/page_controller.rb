class PageController < ApplicationController
  include AchievementsHelper

  def home
    if user_signed_in?
      @user = current_user
      render 'home_logged_in'
    else
      render 'home_not_logged_in'
    end
  end

  def how_it_works
    render 'how_it_works'
  end
end
