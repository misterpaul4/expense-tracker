class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :budget, numericality: { greater_than: 0, allow_nil: true }
  validates_associated :expenses, :transactions

  has_many :transactions, foreign_key: 'creator_id', class_name: 'Transaction'
  has_many :expenses
end
