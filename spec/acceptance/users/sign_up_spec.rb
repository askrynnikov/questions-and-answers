require 'acceptance/acceptance_helper'

RSpec.feature 'User sign up', %q{
  in order to be able to ask question
  As an
  I want to be able to sign in
} do

  scenario 'Non-registered user try to sign up' do
    visit new_user_session_path #'/sign_in'
    click_on 'Sign up'

    fill_in 'Email', with: Faker::Internet.unique.email
    fill_in 'Password', with: pass = Faker::Internet.password
    fill_in 'Password confirmation', with: pass
    click_on 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to sign up' do
    @user = create(:user)
    visit new_user_session_path #'/sign_in'
    click_on 'Sign up'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password
    click_on 'Sign up'

    expect(page).to have_content 'error prohibited this user from being saved'
    # ??? expect(current_path).to eq new_user_session_path
  end
end
# save_and_open_page
