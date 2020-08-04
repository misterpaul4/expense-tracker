class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true

  has_many :transactions, foreign_key: 'creator_id', class_name: 'Transaction'
  has_many :expenses
end
