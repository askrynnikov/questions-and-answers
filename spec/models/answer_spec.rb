RSpec.describe Answer, type: :model do
  it_behaves_like 'has_user'
  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe 'associations' do
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:question_id) }

    it { should accept_nested_attributes_for :attachments }
  end

  describe 'best answer' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    it '#mark_best' do
      answer.mark_best
      expect(answer.reload).to be_best
    end

    it 'mark best another answer for question' do
      create(:answer, best: true, question: question)
      best_answer = create(:answer, question: question)
      best_answer.mark_best
      expect(best_answer.reload).to be_best
    end

    it 'best answer only one for question' do
      answers = create_list(:answer, 5, question: question)
      answers.each do |answer|
        answer.mark_best
        expect(answer.reload).to be_best
        expect(question.answers.where(best: true).count).to eq 1
      end
    end
  end

  describe '#first_best' do
    let(:question) { create(:question) }

    it 'first in the list' do
      answers = create_list(:answer, 5, question: question)
      third_answer = answers.third
      third_answer.update(best: true)
      expect(Answer.ordered.first).to eq third_answer
    end
  end

  describe '#create' do
    let(:answer) { build(:answer) }

    context 'notify' do
      it 'should notify after creating ' do
        expect(answer).to receive(:notify)
        answer.run_callbacks(:create)
      end

      it 'should notify subscribers' do
        expect(SubscriptionQuestionJob).to receive(:perform_later).with(answer)
        answer.save
      end
    end
  end
end
