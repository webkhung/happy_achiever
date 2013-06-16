class LessonsController < ApplicationController

  before_filter :find_resource

  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @achievement.lessons.build(params[:lesson])
    @lesson.category = params[:new_category] if params[:new_category].present?
    @lesson.plan_id = @achievement.task.plan.id # todo: add plan and plan_id to achievement
    if @lesson.save
      redirect_to @achievement.task.plan, :notice => "Successfully created lesson."
    else
      render :action => 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      redirect_to @lesson, :notice  => "Successfully updated lesson."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to lessons_url, :notice => "Successfully destroyed lesson."
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end
  end
end
