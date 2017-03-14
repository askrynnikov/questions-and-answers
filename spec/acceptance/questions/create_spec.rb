require 'acceptance/acceptance_helper'

RSpec.feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
}, :js do

  given(:user) {create(:user)}

  context 'as user' do
    before do
      sign_in(user)
      visit questions_path
    end

    scenario 'creates question' do
      click_on 'Ask question'
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text'
      click_on 'Create'

      expect(page).to have_content 'Your question successfully created.'
    end
  end

  context "multiple sessions" do
    scenario "question appears on another user's page" do
      title = 'Title new question'
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask question'
        fill_in 'Title', with: title
        fill_in 'Body', with: 'text text'
        click_on 'Create'

        expect(page).to have_content 'Your question successfully created.'
        expect(page).to have_content title
      end

      Capybara.using_session('guest') do
        expect(page).to have_content title
      end
    end
  end

  scenario 'Non-authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
