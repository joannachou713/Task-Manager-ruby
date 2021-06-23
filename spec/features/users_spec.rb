require 'rails_helper'

RSpec.feature "Users", type: :feature do
  before(:each) do
    @before_count = User.count
    visit signup_path
    within('form') do
      fill_in 'user_name', with: 'aaa'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_tel', with: '0912345678'
      fill_in 'user_password', with: 'foobar'
      fill_in 'user_password_confirmation', with: 'foobar'
    end
  end

  context "Signup" do
    it "invalid signup information" do
      within('form') do
        fill_in 'user_email', with: 'user@invalid'
        fill_in 'user_tel', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
      end
      click_button 'commit'
      expect(User.count).to eq(@before_count)
    end


    it "valid signup information" do
      click_button 'commit'
      expect(User.count).to eq(@before_count+1)
      expect(page).to have_content('Welcome to Task Manager!')
    end
  end
end
