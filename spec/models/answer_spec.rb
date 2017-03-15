RSpec.describe Answer, type: :model do
  describe 'associations' do
    it do
      should belong_to(:question)
    end
  end

  it_behaves_like 'has_user'
  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:question_id) }

    it { should accept_nested_attributes_for :attachments }
  end
end
