class QuestionPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user
  end

  def update?
    user && user.id == record.user_id
  end

  def destroy?
    user && user.id == record.user_id
  end
end
