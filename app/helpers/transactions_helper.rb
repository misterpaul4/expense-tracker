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

  def additional_categories(t)
    cats = t.other_categories
    names = "+("
    if cats.size > 1
      # cats.shift
      cats.each do |cat|
        names = names + (cat + ', ') unless cat == t.category_1.name
      end
      additional_cats = names[0..(names.length - 3)] + ')'
      return additional_cats
    end
  end
end
