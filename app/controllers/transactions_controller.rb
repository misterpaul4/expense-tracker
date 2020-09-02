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
    category = Category.find(params[:category_id])
    transaction = Transaction.find(params[:transaction_id])
    transaction.add_category(category)
    redirect_to edit_transaction_path(transaction)
  end

  def remove_category
    category = Category.find(params[:category_id])
    transaction = Transaction.find(params[:transaction_id])
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
        cat = Category.find(category_params)
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
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
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
