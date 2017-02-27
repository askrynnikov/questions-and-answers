require 'acceptance/acceptance_helper'

RSpec.feature 'Edit question', %q{
In order to fix mistake
As an author of question
I'd like to be able to edit my question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  # given!(:answer) { create(:answer, question: question, user: user) }
  given(:user2) { create(:user) }
  given!(:question2) { create(:question, user: user2) }
  # given!(:answer2) { create(:answer, question: question, user: user2) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).not_to have_link 'Edit question'
  end

  describe 'Authenticated user' do
    before() do
      sign_in(user)
    end

    scenario 'sees link to Edit question', js: true do
      visit question_path(question)
      expect(page).to have_link 'Edit question'
    end

    scenario 'try to edit his answer', js: true do
      visit question_path(question)
      within '.question' do
        expect(page).to_not have_selector 'textarea'
        click_on 'Edit question'
      end

      sleep(1)
      save_and_open_page
      within '.question' do
       expect(page).to have_selector 'textarea'
      end

      question_body = Faker::Lorem.paragraph
      within '.question' do
        fill_in 'question_body', with: question_body
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content question_body
        expect(page).to_not have_selector 'textarea'
      end

      click_on 'Edit question'
      within '.question' do
        expect(page).to have_selector 'textarea'
      end

      question_body = Faker::Lorem.paragraph
      within '.question' do
        fill_in 'question_body', with: question_body
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content question_body
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit other user`s question', js: true do
      visit question_path(question2)
      expect(page).not_to have_link 'Edit question'
    end
  end
end

# save_and_open_page