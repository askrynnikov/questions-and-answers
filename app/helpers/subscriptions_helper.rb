module SubscriptionsHelper
  def user_can_unsubscribe?(entity)
    user_signed_in? && user_subscription(entity).present? && policy(user_subscription(entity)).destroy?
  end

  def user_subscription(entity)
    entity.subscriptions.find_by(user: current_user)
  end
end
