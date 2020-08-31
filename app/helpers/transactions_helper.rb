module TransactionsHelper
  def transaction_number(t_id)
    counter = 1
    @transactions_array.each do |value|
      return counter if value == t_id
      counter += 1
    end
  end
end
