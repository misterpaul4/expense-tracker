require 'rails_helper'

RSpec.describe Transaction, type: :feature do
  def login(user)
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Log in'
  end

  context 'creating a transaction' do
    it 'creates a transaction' do
      user = User.create(username: 'john')
      login(user)
      click_on 'All My Transactions'
      click_on 'ADD NEW'
      fill_in 'Amount', with: 500
      click_on 'Create'
      expect(page).to have_content 'Transaction was successfully created.'
      expect(user.transactions.count).to eql(1)
    end
  end
end
