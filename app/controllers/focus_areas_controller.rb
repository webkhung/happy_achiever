class FocusAreasController < ApplicationController

  before_filter :find_resource

  def index
    @focus_areas = FocusArea.all
  end

  def show
    @focus_area = FocusArea.find(params[:id])
  end

  def new
    @focus_area = FocusArea.new
  end

  def create
    @focus_area = @plan.focus_areas.build(params[:focus_area])
    @focus_area.user = current_user
    if @focus_area.save
      redirect_to new_plan_focus_area_path(@plan, step: params[:step])
      #if params[:step].present?
      #  redirect_to new_plan_focus_area_path(@plan, step: params[:step])
      #else
      #  redirect_to @plan, :notice => "Successfully created focus area."
      #end
    else
      render :action => 'new'
    end
  end

  def edit
    @focus_area = FocusArea.find(params[:id])
    @plan = @focus_area.plan
  end

  def update
    @focus_area = FocusArea.find(params[:id])
    if @focus_area.update_attributes(params[:focus_area])
      redirect_to @focus_area.plan, :notice  => "Successfully updated focus area."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @focus_area = FocusArea.find(params[:id])
    @focus_area.destroy
    redirect_to @focus_area.plan, :notice => "Successfully destroyed focus area."
  end

  def find_resource
    if params.has_key?(:plan_id)
      @plan = Plan.find(params[:plan_id])
    end
  end
end
