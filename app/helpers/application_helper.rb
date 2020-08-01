module ApplicationHelper
  def amount(user, item)
    number_to_currency(item, unit: user.currency.to_s)
  end
end
