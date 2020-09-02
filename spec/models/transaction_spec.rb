require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'Associations' do
    it { should belong_to(:creator).class_name('User') }
    it { should have_and_belong_to_many(:categories) }
  end

  context 'Validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_length_of(:description).is_at_most(50) }
  end
end
