require 'acceptance/acceptance_helper'

RSpec.feature 'Edit answers', %q{
In order to fix mistake
As an author of answer
I'd like to be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user ) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    before() do
      # @request.env['devise.mapping'] = Devise.mapping[user]
      sign_in(user)
      visit question_path(answer.question)
    end

    scenario 'sees link to Edit', js: true do
      # save_and_open_page
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      click_on 'Edit'
      answer_body = Faker::Lorem.paragraph
      within '.answers' do
        fill_in 'answer_body', with: answer_body
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content answer_body
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit other user`s answer', js: true do
    end
  end
end

# save_and_open_page