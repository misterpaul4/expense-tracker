class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { maximum: 12 }
  validates :budget, numericality: { greater_than: 0, allow_nil: true }

  has_many :transactions, foreign_key: 'creator_id', class_name: 'Transaction', dependent: :destroy
  has_many :external_transactions, -> { where category_id: nil }, class_name: 'Transaction', foreign_key: 'creator_id'
  has_many :categories, dependent: :destroy

  def total_expenses
    self.transactions.sum(:amount)
  end
end
