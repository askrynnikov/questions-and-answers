RSpec.describe QuestionPolicy do
  let(:guest) { nil }
  let(:user_question_creater) { create(:user) }
  let(:question) { create(:question, user: user_question_creater) }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user is not an guest' do
      expect(subject).to permit(user_other, Question)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(guest, Question)
    end
  end

  permissions :update?, :destroy? do
    it 'grants access if user is an author' do
      expect(subject).to permit(user_question_creater, question)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(user_other, question)
    end
  end
end