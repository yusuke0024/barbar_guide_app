class SessionsController < ApplicationController
  before_action :redirect_if_already_logged_in, only: [:new, :create]

  def create
    user = User.find_by(email: params[:email])

    unless user&.authenticate(params[:password])
      flash.now[:danger] = "IDかパスワードが間違っているか、会員ではありません。"
      return render :new
    end

    session[:user_id] = user.id
    params[:remember_me] == '1' ? set_cookie(user) : delete_cookie(user)
    redirect_to salons_path, success: "ログインしました"
  end

  def destroy
    delete_cookie(current_user)
    session.delete(:user_id)
    redirect_to salons_path, success: "ログアウトしました"
  end

  private

  def set_cookie(user)
    user.set_remember_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def delete_cookie(user)
    user.delete_remember_digest
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
