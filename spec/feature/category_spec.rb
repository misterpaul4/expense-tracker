require 'rails_helper'

RSpec.describe Category, type: :feature do
  def login(user)
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Log in'
  end

  context 'creates a category' do
    it 'creates a category' do
      user = User.create(username: 'john')
      login(user)
      click_on 'Categories'
      click_on 'ADD NEW'
      fill_in 'Name', with: 'Travel'
      click_on 'Create'
      expect(page).to have_content 'new category added.'
      expect(user.categories.count).to eql(1)
    end

    it 'deletes a category' do
      user = User.create(username: 'jane')
      category = user.categories.build(name: 'Travel', icon: '1.svg')
      user.categories << category
      login(user)
      click_on 'Categories'
      first('.d-flex > a').click
      click_on category.name
      click_on 'Delete'
      expect(page).to have_content 'category and related transactions removed.'
    end
  end

  context 'adds transaction to a category' do
    it 'adds a transaction to a category' do
      user = User.create(username: 'jane')
      category = user.categories.build(name: 'Travel', icon: '1.svg')
      user.categories << category
      login(user)
      click_on 'Categories'
      first('.d-flex > a').click
      click_on 'ADD NEW'
      fill_in 'Amount', with: 500
      click_on 'Save'
      expect(page).to have_content 'Transaction was successfully created.'
    end
  end
end
