class TasksController < ApplicationController

  before_filter :find_resource, only: %w(new create show edit update destroy)
  authorize_resource except: %w(index create new)

  def index
  end

  def show
  end

  def new
  end

  def create
    @task.user = current_user
    if @task.save
      if params[:step].present?
        redirect_to plan_url(@focus_area.plan)
      else
        redirect_to plan_path(@focus_area.plan, modal: 'add_schedule'), :notice => "Successfully created task."
      end
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to @focus_area.plan, :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    plan = @task.plan
    @task.make_archived! unless @task.is_archived?
    redirect_to plan_path(plan), :notice => "Successfully destroyed task."
  end

  def find_resource

    if params.has_key?(:focus_area_id)
      @focus_area = FocusArea.find(params[:focus_area_id])
    end

    case params[:action]
      when 'new'
        @task = Task.new
      when 'create'
        @task = @focus_area.tasks.build(params[:task])
      when 'show', 'edit', 'update', 'destroy'
        @task = Task.find(params[:id])
    end
  end
end
