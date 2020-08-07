class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :budget, numericality: { greater_than: 0, allow_nil: true }

  has_many :transactions, foreign_key: 'creator_id', class_name: 'Transaction'
  has_many :external_transactions, -> { where expense_id: nil }, class_name: 'Transaction', foreign_key: 'creator_id'
  has_many :expenses
end
