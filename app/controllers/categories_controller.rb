class CategoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_category, only: %i[show edit update destroy]
  helper_method :icon_dir

  def index
    @categories = current_user.categories.order(name: :asc)
  end

  def new
    @category = Category.new(icon: '15.svg')
  end

  def new_transaction
    set_category
    @transaction = Transaction.new
  end

  def show
    @categories = @category.categorized_transactions.ordered_by_most_recent
  end

  def icon_dir
    './app/assets/images/icons/categories/'
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'category updated.'
    else
      render :edit
    end
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'new category added.'
    else
      render :new
    end
  end

  def create_transaction
    param = transaction_params
    @transaction = current_user.transactions.build(amount: param[:amount], description: param[:description])
    @category = Category.find(param[:category_id])
    if @transaction.save
      @transaction.add_category(@category)
      redirect_to @category, notice: 'Transaction was successfully created.'
    else
      render :new_transaction
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'transaction category and related transactions removed'
    else
      render :edit, alert: 'cannot delete this category, try again.'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :category_id)
  end
end
