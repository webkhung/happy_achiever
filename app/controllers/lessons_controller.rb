class LessonsController < ApplicationController

  before_filter :find_resource

  authorize_resource except: %w(index create new)

  def index
    @lessons = current_user.lessons.all
  end

  def show
  end

  def new
  end

  def create
    @lesson.category = params[:new_category] if params[:new_category].present?
    @lesson.plan_id = @achievement.task.plan.id # todo: add plan and plan_id to achievement
    @lesson.user_id = current_user.id
    if @lesson.save
      redirect_to plan_path(@achievement.task.plan, modal: 'lesson') + '#achievements', :notice => "Successfully created lesson."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @lesson.update_attributes(params[:lesson])
      redirect_to @lesson, :notice  => "Successfully updated lesson."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @lesson.destroy
    redirect_to lessons_url, :notice => "Successfully destroyed lesson."
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end

    case params[:action]
      when 'new'
        @lesson = Lesson.new
      when 'create'
        @lesson = @achievement.lessons.build(params[:lesson])
      when 'show', 'edit', 'update', 'destroy'
        @lesson = Lesson.find(params[:id])
    end
  end
end
