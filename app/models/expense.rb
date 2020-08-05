class Expense < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true, uniqueness: { message: "that category already exist", case_sensitive: false }, length: { maximum: 20 }
  validates :icon, presence: true
end
