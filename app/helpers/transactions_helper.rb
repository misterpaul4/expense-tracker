module TransactionsHelper
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
