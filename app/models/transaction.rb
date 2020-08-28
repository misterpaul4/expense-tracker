class Transaction < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :categories, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 50 }

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  def add_category(category)
    self.categories << category
  end
end
