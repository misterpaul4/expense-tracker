module TransactionsHelper
  def unselected_categories(user_cat, transaction_cat)
    user_cat.to_a - transaction_cat.to_a
  end

  def update_cat_link(cat)
    add_category_path(category_id: cat.id, transaction_id: @transaction.id)
  end

  def remove_cat_link(cat)
    remove_category_path(category_id: cat.id, transaction_id: @transaction.id)
  end

  def transaction_number(t_id)
    counter = 1
    @transactions_array.each do |value|
      return counter if value == t_id

      counter += 1
    end
  end
end
