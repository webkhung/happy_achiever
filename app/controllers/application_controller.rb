class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :viewing_self?
  helper_method :viewing_profile_page?

  def viewing_self?
    @user == current_user
  end

  def viewing_profile_page?
    params[:controller] == 'users' && params[:action] == 'show' #todo Review.
  end

  rescue_from(CanCan::AccessDenied) do
    redirect_to root_path, alert: 'You are not authorized to take this action.'
  end

end
