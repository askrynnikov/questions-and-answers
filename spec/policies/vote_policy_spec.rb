require_relative "../../lib/pandit/votable_context"

RSpec.describe VotePolicy do
  let(:guest) { nil }
  let(:user_question_creater) { create(:user) }
  let(:question) { create(:question, user: user_question_creater) }
  let(:user_vote_creater) { create(:user) }
  let(:vote) { create(:vote, user: user_vote_creater, votable: question) }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user is not an author question' do
      expect(subject).to permit(VotableContext.new(user_other, question), Vote)
    end

    it 'denies access if user guest or an author question' do
      expect(subject).to_not permit(VotableContext.new(guest, question), Vote)
      expect(subject).to_not permit(VotableContext.new(user_question_creater, question), Vote)
    end
  end

  permissions :destroy? do
    it 'grants access if user is an author' do
      expect(subject).to permit(VotableContext.new(user_vote_creater, question), vote)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(VotableContext.new(guest, question), vote)
      expect(subject).to_not permit(VotableContext.new(user_question_creater, question), vote)
      expect(subject).to_not permit(VotableContext.new(user_other, question), vote)
    end
  end
end