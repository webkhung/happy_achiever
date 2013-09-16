class EmpowermentsController < ApplicationController

  before_filter :find_resource

  def index
    @empowerments = Empowerment.all
  end

  def show
    @empowerment = Empowerment.find(params[:id])
  end

  def new
    @empowerment = Empowerment.new
  end

  def create
    @empowerment = @achievement.empowerments.build(params[:empowerment])
    if @empowerment.save
      if @achievement.state_id == Achievement::UNENERGIZED
        redirect_to root_path, notice: 'Good Job! Achievement created!'
      else
        redirect_to new_achievement_grateful_path @achievement
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @empowerment = Empowerment.find(params[:id])
  end

  def update
    @empowerment = Empowerment.find(params[:id])
    if @empowerment.update_attributes(params[:empowerment])
      redirect_to @empowerment, :notice  => "Successfully updated empowerment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @empowerment = Empowerment.find(params[:id])
    @empowerment.destroy
    redirect_to empowerments_url, :notice => "Successfully destroyed empowerment."
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end
  end
end
