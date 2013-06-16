class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @focus_area = FocusArea.find(params[:focus_area_id])
    @task = Task.find(params[:id])
  end

  def new
    @focus_area = FocusArea.find(params[:focus_area_id])
    @task = Task.new
  end

  def create
    @focus_area = FocusArea.find(params[:focus_area_id]) # param[:focus_area_id] only works if the id is in the path. /focus_area/<focus area id>/
    @task = @focus_area.tasks.build(params[:task])
    if @task.save
      redirect_to @focus_area.plan, :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def edit
    @focus_area = FocusArea.find(params[:focus_area_id])
    @task = Task.find(params[:id])
  end

  def update
    @focus_area = FocusArea.find(params[:focus_area_id])
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to @focus_area.plan, :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    plan = @task.plan
    @task.destroy
    redirect_to plan_path(plan), :notice => "Successfully destroyed task."
  end
end
