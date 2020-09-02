class TransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @transactions = current_user.recent_transactions
  end

  def external_index
    @transactions = current_user.recent_external_transactions
    @icon = '404.svg'
  end

  def index_sort
    @transactions = current_user.ancient_transactions
  end

  def external_index_sort
    @transactions = current_user.ancient_external_transactions
    @icon = '404.svg'
  end

  def add_category
    category = current_user.categories.find(params[:category_id])
    transaction = current_user.transactions.find(params[:transaction_id])
    transaction.add_category(category)
    redirect_to edit_transaction_path(transaction)
  end

  def remove_category
    category = current_user.categories.find(params[:category_id])
    transaction = current_user.transactions.find(params[:transaction_id])
    transaction.remove_category(category)
    redirect_to edit_transaction_path(transaction)
  end

  def new_external
    @transaction = Transaction.new
  end

  def show;
    @transactions = current_user.transactions
    @transactions_array = current_user.transactions.pluck(:id)
  end

  def new
    @transaction = Transaction.new
    @categories = current_user.categories.sort_alphabetically
  end

  def edit
    @categories = current_user.categories.sort_alphabetically
  end


  def create
    parameter = transaction_params
    @transaction = current_user.transactions.build(amount: parameter[:amount], description: parameter[:description])

    if @transaction.save
      category_params = parameter[:category_ids]

      if category_params.present?
        cat = current_user.categories.find(category_params)
        @transaction.add_category(cat)
      end
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  def create_external
    @transaction = current_user.transactions.build(external_transaction_params)
    if @transaction.save
      redirect_to external_transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new_external
    end
  end

  def update
    parameter = transaction_params

    if @transaction.update(amount: parameter[:amount], description: parameter[:description])
      category_params = parameter[:category_ids]

      if category_params.present?
        category = current_user.categories.find(parameter[:category_ids])
        cat = @transaction.add_category(category)
      end
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully deleted.' }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :category_ids)
  end

  def external_transaction_params
    params.require(:transaction).permit(:amount, :description)
  end
end
