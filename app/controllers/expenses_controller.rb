class ExpensesController < ApplicationController
  before_action :authenticate_user
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = current_user.expenses.sort_alphabetically
  end

  def new
    @expense = Expense.new
  end

  def show
    @expenses = @expense.transactions.ordered_by_most_recent
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'category updated.'
    else
      render :edit
    end
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to transactions_path, notice: 'new category added.'
    else
      render :new
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, alert: 'expense category and related transactions removed'
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :icon)
  end
end
