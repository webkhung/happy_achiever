class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.all
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def new
    @achievement = Achievement.new
    @task = Task.find(params[:task_id])
    @date = DateTime.parse(params[:date])
  end

  def create
    @achievement = Achievement.new(params[:achievement])
    if @achievement.save
      if @achievement.state_id < 0
        redirect_to new_achievement_empowerment_path(@achievement)
      else
        if @achievement.task.present?
          redirect_to new_achievement_lesson_path(@achievement)
        else
          redirect_to root_path, :notice => 'Achievement created'
        end
      end
    else
      redirect_to root_url, alert: "Error: #{@achievement.errors.full_messages.to_sentence}."
    end
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(params[:achievement])
      redirect_to @achievement, :notice  => "Successfully updated task achievement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy
    redirect_to achievements_url, :notice => "Successfully destroyed task achievement."
  end
end
