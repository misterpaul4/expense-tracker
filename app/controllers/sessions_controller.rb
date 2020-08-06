class SessionsController < ApplicationController
  def new;
    @user = login_path
  end

  def welcome
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Username not registered! try again or create an account'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
