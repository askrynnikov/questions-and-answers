RSpec.feature 'Index questions', %q{
  You can view a list of questions
} do

  given(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user creates question' do
    visit questions_path
    # save_and_open_page

    expect(page).to have_content 'Title question'
    # expect(page).to have_content 'Body question'
  end
end

# save_and_open_page
