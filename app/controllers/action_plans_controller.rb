class ActionPlansController < ApplicationController
  def index
    @action_plans = ActionPlan.all
  end

  def show
    @action_plan = ActionPlan.find(params[:id])
  end

  def new
    @task = Task.find(params[:task_id])
    @action_plan = ActionPlan.new
  end

  def create
    @task = Task.find(params[:task_id])
    @action_plan = @task.action_plans.new(params[:action_plan])
    if @action_plan.save
      redirect_to @task.plan, :notice => "Successfully created action plan."
    else
      render :action => 'new'
    end
  end

  def edit
    @action_plan = ActionPlan.find(params[:id])
  end

  def update
    @action_plan = ActionPlan.find(params[:id])
    if @action_plan.update_attributes(params[:action_plan])
      redirect_to @action_plan, :notice  => "Successfully updated action plan."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @action_plan = ActionPlan.find(params[:id])
    @action_plan.destroy
    redirect_to action_plans_url, :notice => "Successfully destroyed action plan."
  end
end
