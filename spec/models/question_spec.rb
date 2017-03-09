# frozen_string_literal: true
RSpec.describe Question, type: :model do
  describe 'associations' do
    it do
      should have_many(:answers)
               .dependent(:destroy)
      should have_many(:attachments)
    end
  end

  it_behaves_like 'has_user'

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'attributes' do
    it { should accept_nested_attributes_for :attachments }
  end

  # it 'validates presence of title' do
  #   expect(Question.new(body: '123')).to_not be_valid
  # end
  #
  # it 'validates presence of body' do
  #   expect(Question.new(title: '123')).to_not be_valid
  # end
end
