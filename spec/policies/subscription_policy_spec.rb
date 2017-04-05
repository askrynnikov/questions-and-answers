RSpec.describe SubscriptionPolicy do
  let(:guest) { nil }
  let(:user_subscription_creater) { create(:user) }
  let(:subscription) { create(:subscription, user: user_subscription_creater) }
  let(:user_other) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'grants access if user is not an guest' do
      expect(subject).to permit(user_other, Subscription)
    end

    it 'denies access if user is guest' do
      expect(subject).to_not permit(guest, Subscription)
    end
  end

  permissions :destroy? do
    it 'grants access if user is an author' do
      expect(subject).to permit(user_subscription_creater, subscription)
    end

    it 'denies access if user is not an author' do
      expect(subject).to_not permit(user_other, subscription)
    end
  end
end
