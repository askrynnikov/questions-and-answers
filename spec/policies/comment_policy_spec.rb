RSpec.describe CommentPolicy do
  let(:guest) { nil }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user is not a guest' do
      expect(subject).to permit(user_other, Comment)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(guest, Comment)
    end
  end
end