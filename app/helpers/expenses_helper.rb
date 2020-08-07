module ExpensesHelper
  def transactions(expense)
    expense.transactions.count
  end

  def average(expense)
    (total_expenses(expense) / total_expenses(current_user) * 100).round(1)
  end
end
