# frozen_string_literal: true
RSpec.describe Question, type: :model do
  describe 'associations' do
    it do
      should have_many(:answers).dependent(:destroy)
    end
  end

  it_behaves_like 'has_user'
  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
