class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    unless user&.authenticate(params[:password])
      flash.now[:alert] = "IDかパスワードが間違っているか、会員ではありません。"
      return render :new
    end

    session[:user_id] = user.id
    redirect_to salons_path, notice: "ログインしました"
  end

  def destroy
    session.delete(:user_id)
    redirect_to salons_path, notice: "ログアウトしました"
  end
end
