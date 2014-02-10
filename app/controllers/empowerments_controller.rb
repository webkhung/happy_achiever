class EmpowermentsController < ApplicationController

  before_filter :find_resource

  def new
    @empowerment = Empowerment.new
  end

  def create
    @empowerment = @achievement.empowerments.build(params[:empowerment])
    if @empowerment.save
      if @achievement.state_id == Achievement::UNENERGIZED
        redirect_to root_path(modal: 'achievement')
      else
        redirect_to new_achievement_grateful_path @achievement
      end
    else
      render :action => 'new'
    end
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end
  end
end
