class Expense < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  scope :sort_alphabetically, -> { order(name: :asc) }

  validates :name, presence: true, uniqueness: { message: 'that category already exist', case_sensitive: false, scope: :user }, length: { maximum: 20 }
  validates :icon, presence: true

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

end
