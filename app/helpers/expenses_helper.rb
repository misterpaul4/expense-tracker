module ExpensesHelper
  def transactions(expense)
    expense.transactions.count
  end

  def average(expense)
    (total_expenses(expense) / total_expenses(current_user) * 100).round(1)
  end

  def icon_selected
    icon = "icons/categories/"
    if @expense.icon.present?
      icon = icon + @expense.icon
    else
      icon = icon + "15.svg"
    end

    icon 
  end

  def icons

  end
end
