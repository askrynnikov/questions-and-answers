RSpec.feature 'Create answers', %q{
In order that the community received a answer
As an authenticated user
I want to be able to give an answer
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  scenario 'Authenticated user creates answer' do
    sign_in(user)

    visit question_path(question.id)
    answer_body = Faker::Lorem.paragraph
    fill_in 'answer_body', with: answer_body
    click_on 'Your Answer'
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer_body
  end

  scenario 'Non-authenticated user creates answer' do
    visit question_path(question)
    expect(page).not_to have_selector '#answer_body'
  end
end

# save_and_open_page
