RSpec.describe QuestionPolicy do
  let(:guest) { nil }
  let(:user_question_creater) { create(:user) }
  let(:question) { create(:question, user: user_question_creater) }
  let(:attachment) { create(:attachment, attachable: question) }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :destroy? do
    it 'grants access if user is an author' do
      expect(subject).to permit(user_question_creater, question)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(user_other, question)
    end
  end
end