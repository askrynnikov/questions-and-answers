require_relative '../acceptance_helper'

RSpec.feature 'Delete files of question', %q{
   In order to delete the downloaded file by mistake
   As the author of the question
   I want to be able to delete attached file
 } do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }

  before do
    @expected_file_name = 'attachment1.txt'
    @expected_href = "/uploads/attachment/file/1/#{@expected_file_name}"
  end

  describe 'Authenticated user' do
    context 'Author' do
      scenario 'try delete attached file', js: true do
        sign_in(user)
        visit question_path(question)
        expect(page).to have_link @expected_file_name, href: @expected_href
        page.accept_confirm do
          click_on 'Delete file'
        end
        expect(page).to_not have_link @expected_file_name, href: @expected_href
      end
    end

    context 'not author' do
      scenario 'try delete attached file', js: true do
        sign_in(user2)
        visit question_path(question)
        expect(page).to have_link @expected_file_name, href: @expected_href
        expect(page).to_not have_link 'Delete file'
      end
    end
  end

  scenario 'Non-authenticated user try delete file', js: true do
    visit question_path(question)
    expect(page).to have_link @expected_file_name, href: @expected_href
    expect(page).to_not have_link 'Delete file'
  end
end
