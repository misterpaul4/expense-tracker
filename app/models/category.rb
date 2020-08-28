class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categorized_transactions, class_name: 'Transaction'

  scope :sort_alphabetically, -> { order(name: :asc) }

  validates :name, presence: true, uniqueness: { message: 'that category already exist', case_sensitive: false, scope: 'user_id' }, length: { maximum: 20 }
  validates :icon, presence: true

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  def add_transaction(transaction)
    self.categorized_transactions << transaction
  end

  def total_transactions
    self.categorized_transactions.sum(:amount)
  end
end
