RSpec.describe AnswerPolicy do
  let(:guest) { nil }
  let(:user_question_creater) { create(:user) }
  let(:question) { create(:question, user: user_question_creater) }
  let(:user_answer_creater) { create(:user) }
  let(:answer) { create(:answer, user: user_answer_creater, question: question) }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user is not an guest' do
      expect(subject).to permit(user_other, Answer)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(guest, Answer)
    end
  end

  permissions :update?, :destroy? do
    it 'grants access if user is an author' do
      expect(subject).to permit(user_answer_creater, answer)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(user_other, answer)
    end
  end

  permissions :mark_best? do
    it 'grants access if user is a question author' do
      expect(subject).to permit(user_question_creater, answer)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(user_other, answer)
    end
  end
end
