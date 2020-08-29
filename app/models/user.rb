class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { maximum: 12 }
  validates :budget, numericality: { greater_than: 0, allow_nil: true }

  has_many :transactions, foreign_key: 'creator_id', class_name: 'Transaction', dependent: :destroy
  has_many :categories, dependent: :destroy

  def total_expenses
    self.transactions.sum(:amount)
  end

  def total_external_expenses
    self.ancient_external_transactions.sum(:amount)
  end

  def recent_transactions
    self.transactions.ordered_by_most_recent.includes(:categories)
  end

  def ancient_transactions
    self.transactions.includes(:categories)
  end

  def recent_external_transactions
    self.transactions.ungrouped.ordered_by_most_recent
  end

  def ancient_external_transactions
    self.transactions.ungrouped
  end
end
