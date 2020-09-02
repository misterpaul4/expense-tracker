module ApplicationHelper
  def amount(item)
    number_to_currency(item, unit: current_user.currency.to_s + ' ')
  end

  def balance
    amount(current_user.budget - current_user.total_expenses)
  end

  def date(day)
    day.to_formatted_s(:long)
  end

  def select_icon(transaction)
    category = transaction.category_1
    if category.nil?
      '404.svg'
    else
      category.icon
    end
  end

  def multiple_cat(transaction)
    return transaction.categories.size if transaction.additional_categories?
  end
end
