require 'rails_helper'

RSpec.describe User, type: :feature do
  def login(user)
    visit login_path
    fill_in 'username', with: user.username
    click_on 'Log in'
  end

  context 'login' do
    it 'logs in a user' do
      user = User.create(username: 'john')
      login(user)
      expect(page).to have_content 'Logged in!'
    end
  end
end
