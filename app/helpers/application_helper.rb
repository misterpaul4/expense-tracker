module ApplicationHelper
  def amount(item)
    number_to_currency(item, unit: current_user.currency + " ")
  end
end
