module ApplicationHelper
  def amount(item)
    number_to_currency(item, unit: current_user.currency + " ")
  end

  def balance
    if !!current_user.budget
      "initial budget: #{amount(current_user.budget)} current balance: #{amount(current_user.budget - total_expenses(current_user))}"
    end
  end
end
