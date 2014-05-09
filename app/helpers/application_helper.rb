module ApplicationHelper
  def body_classes
    params[:action] == 'home' ? 'home' : ''
  end

end
