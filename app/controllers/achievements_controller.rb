class AchievementsController < ApplicationController

  before_filter :authenticate_user! # this is called so that you can call current_user
  before_filter :find_resource, only: %w(new create show edit update destroy support)

  authorize_resource except: %w(index create new)

  def index
    @achievements = current_user.achievements.order('achieved_date DESC')
  end

  def show
  end

  # This is used in "Mark Your Achievement" -> click "Achieve" on a schedule ->
  # http://localhost.intuit.com:3000/tasks/41/achievements/new?date=2013-11-14+17%3A00%3A00&duration=120
  def new
    @task = Task.find(params[:task_id])
    @date = DateTime.parse(params[:date])
  end

  def create
    @achievement.user = current_user
    if @achievement.save

      @achievement.create_activity :create, owner: current_user unless @achievement.is_journal?

      if @achievement.state_id < 0
        redirect_to new_achievement_empowerment_path(@achievement)
      elsif @achievement.state_id > 0
        if @achievement.task.present?
          redirect_to new_achievement_lesson_path(@achievement)
        else
          redirect_to root_path(modal: 'achievement')
        end
      else
        redirect_to journal_path(modal: 'journal')
      end
    else
      redirect_to root_url, alert: "Error: #{@achievement.errors.full_messages.to_sentence}."
    end
  end

  def edit
    @date = @achievement.achieved_date
    @task = @achievement.task
  end

  def update
    if @achievement.update_attributes(params[:achievement])
      redirect_to @achievement, :notice  => "Successfully updated task achievement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_url, :notice => "Successfully destroyed task achievement."
  end

  def support
    @achievement.vote :voter => current_user,  :duplicate => true
    User.increment_counter(:supports_count, @achievement.user_id)

    if @achievement.user != current_user
      VotableMailer.votable_email(@achievement, current_user).deliver

      if can?(:view, @achievement)
        redirect_to new_achievement_comment_path @achievement
      else
        redirect_to :back, :notice => "Support sent!"
      end
    else
      redirect_to :back, :notice => "Support sent!"
    end
  end

  def find_resource
    case params[:action]
      when 'new'
        @achievement = Achievement.new
      when 'create'
        @achievement = Achievement.new(params[:achievement])
      when 'show', 'support', 'edit', 'update', 'destroy'
        @achievement = Achievement.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    index
    flash.now[:alert] = 'Record not found'
    render 'index', :status => 404
  end

end
