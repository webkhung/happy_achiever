class AccountablesController < ApplicationController

  before_filter :find_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @accountable.user = current_user
    @accountable.save
    redirect_to root_path, notice: 'Accountable created'
  end

  def update
  end

  def destroy
  end

  def support
    @accountable.vote voter: current_user, duplicate: true
    User.increment_counter(:supports_count, @accountable.user_id)

    if @accountable.user != current_user
      VotableMailer.votable_email(@accountable, current_user).deliver
      redirect_to new_accountable_comment_path @accountable, back: params[:back]
    else
      redirect_to :back
    end
  end

  private

  def find_resource
    case params[:action]
      when 'new'
        @accountable = Accountable.new
      when 'show', 'update', 'destroy', 'support'
        @accountable = Accountable.find(params[:id])
      when 'create'
        @accountable = Accountable.new(params[:accountable])
    end
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = 'Record not found'
    redirect_to root_path, :status => 404
  end

end
