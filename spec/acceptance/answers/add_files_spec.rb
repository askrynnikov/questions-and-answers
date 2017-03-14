require 'acceptance/acceptance_helper'

RSpec.feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer`s author
  I`d like to be able to attach files
}, :js do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'User adds files to answer' do
    before do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'one file' do
      fill_in 'answer_body', with: 'text text'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Your Answer'
      within '.answers' do
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      end
    end

    scenario 'several files' do
      fill_in 'answer_body', with: 'text text'
      click_on 'Add file'
      inputs = all('input[type="file"]')
      inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
      inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
      click_on 'Your Answer'

      within '.answers' do
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
      end
    end
  end

  context 'multiple sessions' do
    scenario "answer with files appears on another user's page" do
      answer_text = 'My answer text'
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end
      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'answer_body', with: answer_text
        click_on 'Add file'
        inputs = all('input[type="file"]')
        inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
        inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
        click_on 'Your Answer'

        within '.answers' do
          expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
          expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
        end
      end

      Capybara.using_session('guest') do
        within '.answers' do
          expect(page).to have_content answer_text
          expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
          expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
        end
      end
    end
  end
end
