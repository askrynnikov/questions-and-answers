RSpec.describe Answer, type: :model do
  describe 'associations' do
    it do
      should belong_to(:question)
      should have_many(:attachments)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:question_id) }

    it { should accept_nested_attributes_for :attachments }
  end
end
