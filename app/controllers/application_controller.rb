class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_admin
    if session[:administrator_id]
      @current_admin ||= Administrator.find_by(id: session[:administrator_id])
    end
  end
  helper_method :current_admin
end
