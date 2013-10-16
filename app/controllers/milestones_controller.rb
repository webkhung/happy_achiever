class MilestonesController < ApplicationController

  before_filter :find_resource

  def index
    @milestones = Milestone.all
  end

  def show
    @milestone = Milestone.find(params[:id])
  end

  def new
    @milestone = Milestone.new
  end

  def create
    @milestone = @plan.milestones.build(params[:milestone])
    if @milestone.save
      redirect_to @plan, :notice => "Successfully created milestone."
    else
      render :action => 'new'
    end
  end

  def edit
    @milestone = Milestone.find(params[:id])
  end

  def update
    @milestone = Milestone.find(params[:id])
    if @milestone.update_attributes(params[:milestone])
      redirect_to @milestone.plan, :notice  => "Successfully updated milestone."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    redirect_to milestones_url, :notice => "Successfully destroyed milestone."
  end

  def find_resource
    if params.has_key?(:plan_id)
      @plan = Plan.find(params[:plan_id])
    end
  end
end