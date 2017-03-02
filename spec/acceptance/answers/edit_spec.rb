require 'acceptance/acceptance_helper'

RSpec.feature 'Edit answers', %q{
In order to fix mistake
As an author of answer
I'd like to be able to edit my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:user2) { create(:user) }
  given!(:answer2) { create(:answer, question: question, user: user2) }
  given(:answer_body) {Faker::Lorem.paragraph}
  given(:answer_body2) {Faker::Lorem.paragraph}

  scenario 'Unauthenticated user try to edit answer', js: true do
    visit question_path(question)

    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    before() do
      # Capybara.default_max_wait_time = 10 # "Это не! работает"
      sign_in(user)
      expect(page).to have_link 'Sign out' # "Это работает!"
      # wait_for_ajax # "Это не! работает"
      # sleep(0.5) # "Это работает!"
      visit question_path(question) #, :visible => true
    end

    scenario 'sees link to Edit', js: true do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      within '.answers' do
        expect(page).to_not have_selector 'textarea'
      end
      click_on 'Edit'
      within '.answers' do
       expect(page).to have_selector 'textarea'
      end

      within '.answers' do
        fill_in 'answer_body', with: answer_body
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content answer_body
        expect(page).to_not have_selector 'textarea'
      end

      click_on 'Edit'
      within '.answers' do
        expect(page).to have_selector 'textarea'
      end

      within '.answers' do
        fill_in 'answer_body', with: answer_body2
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content answer_body2
        expect(page).to_not have_selector 'textarea'
      end

    end

    scenario 'try to edit other user`s answer', js: true do
      within ".answer-#{answer.id}" do
        expect(page).to have_link('Edit')
      end
      within ".answer-#{answer2.id}" do
        expect(page).to_not have_link('Edit')
      end
    end
  end
end
