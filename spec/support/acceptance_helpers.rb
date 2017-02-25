module AcceptanceHelper
  # Capybara.default_max_wait_time = 5

  def sign_in(user)
    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end