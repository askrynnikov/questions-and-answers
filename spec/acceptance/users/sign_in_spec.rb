require 'acceptance/acceptance_helper'

RSpec.feature 'User sign in', %q{
  in order to be able to ask question
  As an
  I want to be able to sign in
} do

  given(:user) {create(:user)}

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: Faker::Internet.unique.email
    fill_in 'Password', with: Faker::Internet.password(8, 20)
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
# save_and_open_page
