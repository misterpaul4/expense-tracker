class ApplicationController < ActionController::Base
  helper_method :current_user, :total_expenses

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def total_expenses
    current_user.transactions.sum(:amount)
  end
end
