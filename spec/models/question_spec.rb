# frozen_string_literal: true
RSpec.describe Question, type: :model do
  it_behaves_like 'has_user'
  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe 'associations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:subscriptions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '#lastday' do
    let!(:questions) { create_list(:question, 2) }
    let!(:old_questions) { create_list(:question, 2, created_at: 2.day.ago) }

    it 'returns questions lastday' do
      expect(Question.lastday).to eq questions
    end

    it 'not returns old questions' do
      expect(Question.lastday).to_not eq old_questions
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:question) { build(:question, user: user) }

    context 'subscribe' do
      it 'should subscribe after creating ' do
        expect(question).to receive(:subscribe)
        question.run_callbacks(:create)
      end

      it 'should save author subscription' do
        question.save
        expect(question.subscriptions).to include(Subscription.find_by(user_id: user.id, question_id: question.id))
      end
    end
  end
end
