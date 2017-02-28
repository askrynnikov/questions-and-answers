require 'acceptance/acceptance_helper'

RSpec.feature 'Delete answer', %q{
   In order to be able delete wrong answer
   As an authenticated user
   I want to be able to delete an answer
 } do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  # given!(:answer2) { create(:answer, user: user2, question: question) }

  scenario 'Authenticated user delete his answer', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content answer.body
    page.accept_confirm do
      click_on 'Delete answer'
    end
    expect(page).to_not have_content answer.body
  end

  scenario 'Authenticated user trying to delete not his answer' do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_link('Delete answer')
  end

  scenario 'Non-authenticated user tries delete answer' do
    visit question_path(question)
    expect(page).to_not have_link('Delete answer')
  end
end
