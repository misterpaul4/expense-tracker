class TransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
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

  def new_external
    @transaction = Transaction.new
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @categories = current_user.categories.sort_alphabetically
  end

  # GET /transactions/1/edit
  def edit
    @categories = current_user.categories.sort_alphabetically
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = current_user.transactions.build(transaction_params)

    if @transaction.save
      category_params = transaction_params[:category_ids]

      if category_params.present?
        categories = Category.find(category_params)
        @transaction.add_category(categories)
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
    params.require(:transaction).permit(:amount, :description, :category_ids)
  end

  def external_transaction_params
    params.require(:transaction).permit(:amount, :description)
  end
end
