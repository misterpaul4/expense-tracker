class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :expense

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }
end
