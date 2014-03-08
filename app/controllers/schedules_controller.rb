class SchedulesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_resource

  authorize_resource except: %w(index create new)

  def index
    @schedules = current_user.schedules.all
    @plans = current_user.plans.all
  end

  def new
    @date = Date.parse(params[:date])
  end

  def create
    @schedule.user = current_user
    @schedule.update_attribute(:scheduled_date, "#{params[:schedule][:scheduled_date]} #{params[:date][:hour]}:#{params[:date][:minute]}")

    if @schedule.save
      if params[:task_id].present?
        redirect_to @schedule.task.plan, :notice => "Successfully created schedule."
      else
        redirect_to schedules_path
      end
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    params[:schedule][:scheduled_date] = "#{params[:schedule][:scheduled_date]} #{params[:date][:hour]}:#{params[:date][:minute]}"
    if @schedule.update_attributes(params[:schedule])
      redirect_to schedules_path, :notice  => "Successfully updated schedule."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_url, :notice => "Successfully destroyed schedule."
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end

    case params[:action]
      when 'new'
        @schedule = Schedule.new
      when 'create'
        @task = Task.find(params[:schedule][:task_id] || params[:task_id])
        @schedule = @task.schedules.build(params[:schedule])
      when 'edit', 'update', 'destroy'
        @schedule = Schedule.find(params[:id])
    end
  end

end
