class FocusAreasController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_resource, only: %w(new create show edit update destroy)
  authorize_resource except: %w(index create new)

  #def index
  #  @focus_areas = current_user.focus_areas.all
  #end

  def show
  end

  def new
  end

  def create
    @focus_area = @plan.focus_areas.build(params[:focus_area])
    @focus_area.user = current_user
    if @focus_area.save
      redirect_to new_plan_focus_area_path(@plan)
    else
      render :action => 'new'
    end
  end

  def edit
    @plan = @focus_area.plan
  end

  def update
    if @focus_area.update_attributes(params[:focus_area])
      redirect_to @focus_area.plan, :notice  => "Successfully updated focus area."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @focus_area.make_archived! unless @focus_area.is_archived?
    redirect_to @focus_area.plan, :notice => "Successfully destroyed focus area."
  end

  def find_resource
    if params.has_key?(:plan_id)
      @plan = Plan.find(params[:plan_id])
    end

    case params[:action]
      when 'new'
        @focus_area = FocusArea.new
      when 'create'
        @focus_area = @plan.focus_areas.build(params[:focus_area])
      when 'show', 'edit', 'update', 'destroy'
        @focus_area = FocusArea.find(params[:id])
    end
  end

end
