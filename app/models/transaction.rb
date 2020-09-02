class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :ungrouped, lambda {
    joins('LEFT JOIN categories_transactions ON transactions.id = categories_transactions.transaction_id')
      .where('categories_transactions.transaction_id IS NULL')
  }
  scope :grouped, lambda {
    joins('JOIN categories_transactions ON transactions.id = categories_transactions.transaction_id')
  }

  def add_category(category)
    categories << category
  end

  def remove_category(category)
    categories.delete(category)
  end

  def category_1
    categories[0]
  end

  def additional_categories?
    return true if categories.size > 1

    false
  end
end
