RSpec.describe Answer, type: :model do
  describe 'associations' do
    it do
      should belong_to(:question)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:question_id) }
  end
end
