class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :expense

  validates :amount, presence: true
end
