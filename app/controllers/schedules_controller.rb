class SchedulesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @schedules = current_user.schedules.all
    @plans = current_user.plans.all
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = Schedule.new
    @date = Date.parse(params[:date])
  end

  def create
    @task = Task.find(params[:schedule][:task_id] || params[:task_id])
    @schedule = @task.schedules.build(params[:schedule])
    @schedule.user = current_user
    @schedule.update_attribute(:scheduled_date, "#{params[:schedule][:scheduled_date]} #{params[:date][:hour]}:#{params[:date][:minute]}")

    if @schedule.save
      if params[:task_id].present?
        redirect_to @schedule.task.plan, :notice => "Successfully created schedule."
      else
        redirect_to schedules_path, :notice => "Successfully created schedule."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    params[:schedule][:scheduled_date] = "#{params[:schedule][:scheduled_date]} #{params[:date][:hour]}:#{params[:date][:minute]}"
    if @schedule.update_attributes(params[:schedule])
      redirect_to :back, :notice  => "Successfully updated schedule."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_url, :notice => "Successfully destroyed schedule."
  end
end
