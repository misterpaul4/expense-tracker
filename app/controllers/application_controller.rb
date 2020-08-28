class ApplicationController < ActionController::Base
  helper_method :current_user, :total_expenses, :user_logged_in?, :total_external_expenses

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def total_expenses(item)
  #   item.transactions.sum(:amount)
  # end

  def total_external_expenses(item)
    item.external_transactions.sum(:amount)
  end

  def user_logged_in?
    return true if session[:user_id]

    false
  end

  def authenticate_user
    redirect_to welcome_path unless user_logged_in?
  end
end
