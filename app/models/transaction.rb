class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :ungrouped, -> {
    joins("LEFT JOIN categories_transactions ON transactions.id = categories_transactions.transaction_id")
    .where("categories_transactions.transaction_id IS NULL")
  }

  def add_category(category)
    self.categories << category
  end

  def remove_category(category)
    self.categories.delete(category)
  end

  def category_1
    self.categories.last
  end

  def additional_categories?
    return true if self.categories > 1
    false
  end

  def other_categories
    self.categories.pluck(:name)
  end
end
