RSpec.feature 'Delete question', %q{
   In order to be able delete wrong question
   As user
   I want delete question
 } do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user delete his question' do
    sign_in(user)
    visit question_path(question.id)
    # click_on 'Delete question'

    # expect(page).to have_content question.title
  end

  # scenario 'Authenticated user delete another question' do
  #   user2 = create(:user)
  #   sign_in(user2)
  #   visit question_path(question)
  #
  #   expect(page).not_to have_content 'Delete question'
  # end
  #
  # scenario 'Non-authenticated user tries delete question' do
  #   visit question_path(question)
  #
  #   expect(page).not_to have_content 'Delete question'
  # end
end