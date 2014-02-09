class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :viewing_self?

  def viewing_self?
    @user == current_user
  end

  rescue_from(CanCan::AccessDenied) do
    redirect_to root_path, alert: 'You are not authorized to take this action.'
  end

end
