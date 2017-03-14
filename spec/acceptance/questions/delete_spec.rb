require 'acceptance/acceptance_helper'

RSpec.feature 'Delete question', %q{
   In order to be able delete wrong question
   As user
   I want delete question
 }, :js do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user delete his question' do
    sign_in(user)
    visit question_path(question)
    page.accept_confirm do
      click_on 'Delete question'
    end

    expect(page).to have_content 'Your question successfully deleted.'
    expect(page).not_to have_content question.title
  end

  scenario 'Authenticated user trying to delete not his question'  do
    user2 = create(:user)
    sign_in(user2)
    visit question_path(question)

    expect(page).not_to have_content 'Delete question'
  end

  scenario 'Non-authenticated user tries delete question' do
    visit question_path(question)

    expect(page).not_to have_content 'Delete question'
  end
end
