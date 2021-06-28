require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.feature "Users", type: :feature do
  let!(:before_count){ User.count }
  let!(:signup) do
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
      expect(User.count).to eq(before_count)
    end


    it "valid signup information" do
      click_button 'commit'
      expect(User.count).to eq(before_count+1)
      expect(page).to have_content('Welcome to Task Manager!')
    end
  end

  context 'Update profiles' do
    it 'invalid update infos' do
      sign_in
      click_link 'Settings'

      within('form') do
        fill_in 'user_name', with:''
        fill_in 'user_email', with:''
      end
      click_button 'commit'
      expect(page).to have_content('不能為空白')
    end

    it 'valid update infos' do
      sign_in
      click_link 'Settings'

      within('form') do
        fill_in 'user_name', with:'newname'
        fill_in 'user_email', with:'newname@newname.com'
        fill_in 'user_password', with:'foobar'
        fill_in 'user_password_confirmation', with:'foobar'
      end
      click_button 'commit'
      expect(page).to have_content('newname@newname.com')
    end

    it 'protect not logged in' do
      sign_up
      click_link 'logout'
      visit '/users/1/edit'
      expect(page).to have_content('Please log in.')
      visit '/users/1'
      expect(page).to have_content('Please log in.')
    end
  end
end
