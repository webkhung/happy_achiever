class PlansController < ApplicationController

  before_filter :authenticate_user! # this is called so that you can call current_user
  before_filter :find_resource, only: %w(new create show edit update destroy support)

  authorize_resource except: %w(index create new)

  def index
    @plans = current_user.plans.all
  end

  def show
    @milestones = @plan.milestones.sort do |a,b|
      comp = ((a.status == 2 ? 2 : 0) <=> (b.status == 2 ? 2 : 0))
      if(a.status == 2 && b.status == 2)
        comp.zero? ? (b.target <=> a.target) : comp
      else
        comp.zero? ? (a.target <=> b.target) : comp
      end
    end
    render :action => 'show'
  end

  def new
    focus_area = @plan.focus_areas.build
    #focus_area.tasks.build
    2.times { focus_area.tasks.build }

    @plan.milestones.build # this basically kind of like building an empty milestone in memory so that the form can loop thru it.

    #3.times do
    #  focus_area = @plan.focus_areas.build
    #  2.times { focus_area.tasks.build }
    #end
  end

  def create
    @plan.user = current_user
    @plan.focus_areas.each do |fa|
      fa.user = current_user
      fa.tasks.each { |t| t.user = current_user }
    end

    if @plan.save
      @plan.create_activity :create, owner: current_user if @plan.privacy <= Plan::SHOW_GOAL_TITLE_PIC_TO_PUBLIC
      @plan.tasks.each{ |t| t.plan = @plan; t.save() }
      redirect_to plan_path(@plan, modal: 'plan'), :notice => "Successfully created goal."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated goal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @plan.make_archived! unless @plan.is_archived?
    redirect_to plans_url, :notice => "Successfully destroyed goal."
  end

  def support
    @plan.vote :voter => current_user,  :duplicate => true
    #@plan.vote :voter => current_user,  :duplicate => true, vote: 'bad'
    redirect_to :back
  end

  def find_resource
    case params[:action]
      when 'new', 'create'
        @plan = Plan.new(params[:plan])
      when 'show', 'support', 'edit', 'update', 'destroy'
        @plan = Plan.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    index
    flash.now[:alert] = 'Record not found'
    render 'index', :status => 404
  end

end
