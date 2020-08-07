require 'rails_helper'
RSpec.describe User, type: :model do
  context 'Associations' do
    it { should have_many(:transactions).with_foreign_key('creator_id').class_name('Transaction') }
    it { should have_many(:external_transactions).conditions(expense_id: nil).with_foreign_key('creator_id') }
    it { should have_many(:expenses) }
  end

  context 'Validations' do
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username) }
    it { should validate_numericality_of(:budget).is_greater_than(0).allow_nil }
  end
end
