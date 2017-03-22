module AcceptanceHelper
  # Capybara.default_max_wait_time = 5

  def sign_in(user)
    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_link 'Sign out' # "Это     работает!"
    # sleep(0.5)                         # "Это     работает!"
    # wait_for_ajax                      # "Это не! работает"
  end
end