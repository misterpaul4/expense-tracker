class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :expense

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :ordered_by_most_ancient, -> { order(created_at: :asc) }
end
