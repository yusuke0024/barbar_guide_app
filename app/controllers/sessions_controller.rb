class SessionsController < ApplicationController
  before_action :redirect_if_already_logged_in, only: [:new, :create]
  
  def create
    user = User.find_by(email: params[:email])

    unless user&.authenticate(params[:password])
      flash.now[:danger] = "IDかパスワードが間違っているか、会員ではありません。"
      return render :new
    end

    session[:user_id] = user.id
    redirect_to salons_path, success: "ログインしました"
  end

  def destroy
    session.delete(:user_id)
    redirect_to salons_path, success: "ログアウトしました"
  end
end
