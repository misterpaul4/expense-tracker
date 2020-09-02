require 'rails_helper'

RSpec.describe Transaction, type: :feature do
  def login(user)
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Log in'
  end

  context 'creating and deleting a transaction' do
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

    it 'deletes a transaction' do
      user = User.create(username: 'joe')
      transaction = user.transactions.build(amount: 300)
      user.transactions << transaction
      login(user)
      click_on 'All My Transactions'
      first('.container > a').click
      click_on('Delete')
      expect(page).to have_content 'Transaction was successfully deleted.'
      expect(user.transactions.count).to eql(0)
    end
  end
end
