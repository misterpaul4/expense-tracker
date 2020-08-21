class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  # belongs_to :expense, optional: true
  has_and_belongs_to_many :expenses
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
end
