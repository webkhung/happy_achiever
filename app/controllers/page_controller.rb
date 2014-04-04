class PageController < ApplicationController
  include AchievementsHelper

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

  def journal
    @achievements = current_user.achievements.order('achieved_date DESC')
    @plans = current_user.plans
    @milestones = []
    current_user.plans.each do |p|
      @milestones = @milestones + p.milestones.completed
    end
    #@milestones = current_user.plans.map{ |p| p.milestones.completed } #todo: How to do it this way? using join or sth


    render 'journal'
  end
end
