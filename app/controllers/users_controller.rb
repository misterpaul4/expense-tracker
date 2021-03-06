class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[new create]
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def edit; end

  def profile; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'profile updated.'
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'account created.'
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      redirect_to welcome_path, notice: 'account deleted.'
    else
      redirect_to edit_user_path, alert: 'cannot delete account, try again.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :currency, :budget)
  end
end
