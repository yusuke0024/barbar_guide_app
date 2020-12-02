class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  helper_method :logged_in?, :current_user

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      @current_user = user if user&.authenticated?(cookies[:remember_token])
    end
  end

  private

  def redirect_if_already_logged_in
    if logged_in?
      flash[:danger] = "すでにログインしています"
      redirect_to root_path
    end
  end

  def redirect_if_yet_logged_in
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to root_path
    end
  end

  def redirect_if_normal_user
    unless current_user.admin?
      flash[:danger] = "管理者ではありません"
      redirect_to root_path
    end
  end
end
