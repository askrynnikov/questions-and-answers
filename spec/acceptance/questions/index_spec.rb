require 'acceptance/acceptance_helper'

RSpec.feature 'Index questions', %q{
in order To read the questions
As a user
It has the ability to view issues
} do

  given(:questions) { create_list(:question, 2) }

  scenario 'User views question' do
    questions
    visit questions_path

    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
  end
end
