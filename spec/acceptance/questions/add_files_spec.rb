require 'acceptance/acceptance_helper'

RSpec.feature 'Add files to question', %q{
  In order to illustrate my question
  As an question`s author
  I`d like to be able to attach files
} do

  given(:user) { create(:user) }

  # background do
  #   sign_in(user)
  #   visit new_question_path
  # end

  scenario 'User adds several files when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text question'
    click_on 'Add file'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/support/mocks/attachment1.txt")
    inputs[1].set("#{Rails.root}/spec/support/mocks/attachment2.txt")
    click_on 'Create'
    expect(page).to have_link 'attachment1.txt', href: '/uploads/attachment/file/1/attachment1.txt'
    expect(page).to have_link 'attachment2.txt', href: '/uploads/attachment/file/2/attachment2.txt'
  end

  scenario 'User adds file when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/support/mocks/attachment1.txt"
    click_on 'Create'
    expect(page).to have_link 'attachment1.txt', href: '/uploads/attachment/file/1/attachment1.txt'
  end

  scenario 'Non-authenticated user creates question', js: true do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
