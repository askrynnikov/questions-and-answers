class SubscriptionPolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user && user.id == record.user_id
  end
end
