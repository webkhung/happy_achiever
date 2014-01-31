class PlansController < ApplicationController

  before_filter :authenticate_user! #, except: [:index]

  def index
    @plans = current_user.plans.all
  end

  def show
    @plan = Plan.find(params[:id])
    render :action => 'show'
    #if params[:step] == 'mechanic'
    #  render 'mechanic'
    #else
    #  render :action => 'show'
    #end
  end

  def new
    @plan = Plan.new
    3.times do
      focus_area = @plan.focus_areas.build
      2.times { focus_area.tasks.build }
    end
  end

  def create
    @plan = Plan.new(params[:plan])
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
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated plan."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plans_url, :notice => "Successfully destroyed plan."
  end
end
