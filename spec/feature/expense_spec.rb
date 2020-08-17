require 'rails_helper'

RSpec.describe Transaction, type: :feature do
  def login(user)
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Log in'
  end

  context 'creates an expense category' do
    it 'creates a category' do
      user = User.create(username: 'john')
      login(user)
      click_on 'Expense Categories'
      click_on 'ADD NEW'
      fill_in 'Name', with: 'Travel'
      click_on 'Create'
      expect(page).to have_content 'new category added.'
      expect(user.expenses.count).to eql(1)
    end
  end
end
