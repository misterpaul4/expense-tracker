# rubocop:disable Style/MultipleComparison
module ExpensesHelper
  def transactions(expense)
    expense.transactions.count
  end

  def average(expense)
    (total_expenses(expense) / total_expenses(current_user) * 100).round(1)
  end

  def icons
    collection = []
    Dir.foreach(icon_dir) do |img|
      next if img == '.' or img == '..'

      collection.push([image_tag("icons/categories/#{img}"), img]) unless img.eql? '404.svg'
    end

    collection
  end
end
# rubocop:enable Style/MultipleComparison
