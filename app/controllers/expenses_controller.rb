class ExpensesController < ApplicationController
  before_action :authenticate_user
  before_action :set_expense, only: %i[show edit update destroy]
  helper_method :icon_dir

  def index
    @expenses = current_user.expenses.order(name: :asc)
  end

  def new
    @expense = Expense.new(icon: '15.svg')
  end

  def new_transaction
    set_expense
    @transaction = Transaction.new(expense_id: @expense.id)
  end

  def show
    @expenses = @expense.transactions.ordered_by_most_recent
  end

  def icon_dir
    './app/assets/images/icons/categories/'
  end

  def edit; end

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
      redirect_to expenses_path, notice: 'new category added.'
    else
      render :new
    end
  end

  def create_transaction
    @transaction = current_user.transactions.build(transaction_params)
    @expense = Expense.find(@transaction.expense_id)
    if @transaction.save
      redirect_to @expense, notice: 'Transaction was successfully created.'
    else
      render :new_transaction
    end
  end

  def destroy
    if @expense.destroy
      redirect_to expenses_path, notice: 'transaction category and related transactions removed'
    else
      render :edit, alert: 'cannot delete this category, try again.'
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :icon)
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :expense_id)
  end
end
