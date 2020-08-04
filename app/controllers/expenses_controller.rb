class ExpensesController < ApplicationController
  before_action :authenticate_user

  def index
    @expenses = current_user.expenses
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to transactions_path, notice: 'new category added.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :icon)
  end
end
