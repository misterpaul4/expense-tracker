module ApplicationHelper
  def amount(item)
    number_to_currency(item, unit: current_user.currency.to_s + ' ')
  end

  def balance
    amount(current_user.budget - total_expenses(current_user)).to_s
  end

  def date(day)
    day.to_formatted_s(:long)
  end
end
