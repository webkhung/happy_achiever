class PlansController < ApplicationController

  before_filter :authenticate_user! #, except: [:index]

  def index
    @plans = current_user.plans.all
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(params[:plan])
    @plan.user = current_user
    if @plan.save
      redirect_to @plan, :notice => "Successfully created plan."
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
