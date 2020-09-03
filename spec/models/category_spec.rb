require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:categorized_transactions) }
  end

  context 'Validations' do
    it { should validate_presence_of(:icon) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_uniqueness_of(:name).with_message('that category already exist').case_insensitive.scoped_to('user_id') }
  end
end
