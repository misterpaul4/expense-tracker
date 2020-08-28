# rubocop:disable Style/MultipleComparison
module CategoriesHelper
  def transactions(category)
    category.categorized_transactions.count
  end

  def average(category)
    ((category.total_transactions / current_user.total_expenses) * 100).round(1)
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
