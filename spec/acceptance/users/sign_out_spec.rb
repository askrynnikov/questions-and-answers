require 'acceptance/acceptance_helper'

RSpec.feature 'User sign out', %q{
  in order to end session
  As an user
  I want to be able to sign out
} do

  given(:user) {create(:user)}

  scenario 'Authenticated user sign out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
