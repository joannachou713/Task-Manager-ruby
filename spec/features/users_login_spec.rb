require 'rails_helper'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.feature "UsersLogins", type: :feature do
  context "Capture login" do
    it "login with invalid information" do
      visit login_path
      within('form') do
        fill_in 'session_email', with:''
        fill_in 'session_password', with:''
      end
      click_button 'commit'
      expect(page).to have_content('Invalid email/password combination')
      visit signup_path
      expect(page).not_to have_content('Invalid email/password combination')
    end

    it "login with valid information" do
      sign_in
      expect(page).to have_content('aaa')
    end

  end

end
