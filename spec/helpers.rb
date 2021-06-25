module Helpers
  def sign_in
    # here is where you can put the steps to fill out the log in form
    sign_up
    click_link 'logout'
    visit login_path
    within('form') do
      fill_in 'session_email', with:'user@example.com'
      fill_in 'session_password', with:'foobar'
    end
    click_button 'commit'
  end

  def sign_up
    visit signup_path
    within('form') do
      fill_in 'user_name', with: 'aaa'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_tel', with: '0912345678'
      fill_in 'user_password', with: 'foobar'
      fill_in 'user_password_confirmation', with: 'foobar'
    end
    click_button 'commit'
  end
end