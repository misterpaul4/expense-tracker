class TransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = current_user.transactions.ordered_by_most_recent.includes([:expense])
    @total_transactions = current_user.transactions.sum(:amount)
    @transactions_size = !@transactions.empty?
  end

  def external_index
    @transactions = current_user.external_transactions.ordered_by_most_recent.includes([:expense])
    @transactions_size = !@transactions.empty?
    @icon = '404.svg'
  end

  def index_sort
    @transactions = current_user.transactions.includes([:expense])
    @total_transactions = current_user.transactions.sum(:amount)
    @transactions_size = !@transactions.empty?
  end

  def external_index_sort
    @transactions = current_user.external_transactions.includes([:expense])
    @transactions_size = !@transactions.empty?
    @icon = '404.svg'
  end

  def new_external
    @transaction = Transaction.new(expense_id: nil)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @categories = current_user.expenses.sort_alphabetically
  end

  # GET /transactions/1/edit
  def edit
    @categories = current_user.expenses.sort_alphabetically
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = current_user.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def create_external
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to external_transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new_external
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully deleted.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:amount, :description, :expense_id)
  end
end
