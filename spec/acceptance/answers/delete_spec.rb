RSpec.feature 'Delete answer', %q{
   In order to be able delete wrong answer
   As an authenticated user
   I want to be able to delete an answer
 } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, user: user, question: question) }

  scenario 'Authenticated user delete his answer' do
    sign_in(user)
    visit question_path(answer.question)
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content answer.body
  end

  scenario 'Authenticated user trying to delete not his answer' do
    user2 = create(:user)
    sign_in(user2)
    visit question_path(answer.question)

    expect(page).not_to have_content 'Delete answer'
  end

  scenario 'Non-authenticated user tries delete answer' do
    visit question_path(answer.question)

    expect(page).not_to have_content 'Delete answer'
  end
end
# save_and_open_page