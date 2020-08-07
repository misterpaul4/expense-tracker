module TransactionsHelper
  def active_link
    current_url = request.env['PATH_INFO']
    if current_url.exclude? 'sort'
      return ["Most recent", transactions_path] unless current_url.include? 'external'
      ["Most recent", external_transactions_path]
    else
      return ["Most ancient", sort_transactions_path] unless current_url.include? 'external'
      ["Most ancient", sort_external_transactions_path]
    end
  end

  def inactive_link
    current_url = request.env['PATH_INFO']
    if current_url.exclude? 'sort'
      return ["Most ancient", sort_transactions_path] unless current_url.include? 'external'
      ["Most ancient", sort_external_transactions_path]    
    else
      return ["Most recent", transactions_path] unless current_url.include? 'external'
      ["Most recent", external_transactions_path]    
    end
  end
end
