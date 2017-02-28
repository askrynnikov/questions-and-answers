require 'acceptance/acceptance_helper'

RSpec.feature 'View answers', %q{
The user can view the question and answers it.
} do
  given(:question) { create(:question, :with_answers) }

  scenario 'Any user view question and answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content question.answers[0].body
    expect(page).to have_content question.answers[1].body
  end
end
