class PlansController < ApplicationController

  before_filter :authenticate_user! # this is called so that you can call current_user
  before_filter :find_resource, only: %w(new create show edit update destroy)

  authorize_resource except: %w(index create new)

  def index
    @plans = current_user.plans.all
  end

  def show
    render :action => 'show'
  end

  def new
    3.times do
      focus_area = @plan.focus_areas.build
      2.times { focus_area.tasks.build }
    end
  end

  def create
    @plan.user = current_user
    @plan.focus_areas.each do |fa|
      fa.user = current_user
      fa.tasks.each { |t| t.user = current_user }
    end

    if @plan.save
      @plan.tasks.each{ |t| t.plan = @plan; t.save() }
      redirect_to plan_path(@plan, modal: 'plan'), :notice => "Successfully created plan."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated plan."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @plan.make_archived! unless @plan.is_archived?
    redirect_to plans_url, :notice => "Successfully destroyed plan."
  end

  def find_resource
    case params[:action]
      when 'new', 'create'
        @plan = Plan.new(params[:plan])
      when 'show'
        @plan = Plan.find(params[:id])
      when 'edit', 'update', 'destroy'
        @plan = Plan.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    index
    flash.now[:alert] = 'Record not found'
    render 'index', :status => 404
  end

end
