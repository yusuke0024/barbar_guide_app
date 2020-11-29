class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    unless user&.authenticate(params[:password])
      return render :new
    end

    session[:user_id] = user.id
    redirect_to salons_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to salons_path
  end
end
