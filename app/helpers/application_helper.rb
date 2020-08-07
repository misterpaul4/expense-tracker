module ApplicationHelper
  def amount(item)
    number_to_currency(item, unit: current_user.currency + " ")
  end

  def balance
    "#{amount(current_user.budget - total_expenses(current_user))}"
  end

  def date(day)
    day.to_formatted_s(:long)
  end
end
