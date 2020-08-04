class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
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
