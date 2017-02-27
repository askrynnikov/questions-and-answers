require 'acceptance/acceptance_helper'

RSpec.feature 'Best answer', %q{
In order to choose a best answer
Author of question
is able to choose a best asnwer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:user2) { create(:user) }
  given!(:answer2) { create(:answer, question: question, user: user2) }

  scenario 'Unauthenticated user try to choose best answer', js: true do
    visit question_path(question)
    expect(page).not_to have_link 'Mark best'
  end

  describe 'Authenticated user' do
    scenario 'try to choose the best answer to his question', js: true do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Answer best'
      within ".answer-#{answer.id}" do
        click_on 'Mark best'
        expect(page).to have_content 'Answer best'
      end
      within ".answer-#{answer2.id}" do
        click_on 'Mark best'
        expect(page).to have_content 'Answer best'
      end
      within ".answer-#{answer.id}" do
        expect(page).to_not have_content 'Answer best'
      end
    end

    scenario 'try to choose the best answer to not his question', js: true do
      sign_in(user2)
      visit question_path(question)
      expect(page).not_to have_link 'Mark best'
    end
  end
end

# save_and_open_page