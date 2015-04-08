class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protected
  def layout_by_resource
    return "welcome" if controller_name=="sessions"
    "application"
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
end
