class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  helper_method :logged_in?, :current_user

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
