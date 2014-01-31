class GratefulsController < ApplicationController

  before_filter :find_resource

  def index
    @gratefuls = Grateful.all
  end

  def show
    @grateful = Grateful.find(params[:id])
  end

  def new
    @grateful = Grateful.new
  end

  def create
    @grateful = @achievement.gratefuls.build(params[:grateful])
    @grateful.user = current_user
    if @grateful.save
      redirect_to root_path(modal: 'grateful'), :notice => "Successfully created grateful."
    else
      render :action => 'new'
    end
  end

  def edit
    @grateful = Grateful.find(params[:id])
  end

  def update
    @grateful = Grateful.find(params[:id])
    if @grateful.update_attributes(params[:grateful])
      redirect_to @grateful, :notice  => "Successfully updated grateful."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @grateful = Grateful.find(params[:id])
    @grateful.destroy
    redirect_to gratefuls_url, :notice => "Successfully destroyed grateful."
  end

  def find_resource
    if params.has_key?(:achievement_id)
      @achievement = Achievement.find(params[:achievement_id])
    end
  end
end
