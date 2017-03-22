require 'acceptance/acceptance_helper'

RSpec.feature 'User sign up', %q{
  in order to be able to ask question
  As an
  I want to be able to sign in
} do

  scenario 'Non-registered user try to sign up' do
    visit new_user_session_path #'/sign_in'
    click_on 'Sign up'

    fill_in 'Email', with: email = Faker::Internet.unique.email
    fill_in 'Password', with: password = Faker::Internet.password
    fill_in 'Password confirmation', with: password
    click_on 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
    expect(page).to have_content 'Please follow the link to activate your account.'

    open_email(email)
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
    expect(current_path).to eq new_user_session_path
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
  end
end
