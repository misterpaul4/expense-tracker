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

  def active_link
    if request.env['PATH_INFO'].exclude? 'sort'
      ["Most recent", transactions_path]
    else
      ["Most ancient", sort_transactions_path]
    end
  end

  def inactive_link
    if request.env['PATH_INFO'].exclude? 'sort'
      ["Most ancient", sort_transactions_path]
    else
      ["Most recent", transactions_path]
    end
  end
end
