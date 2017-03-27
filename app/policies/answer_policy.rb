class AnswerPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user && user.id == record.user_id
  end

  def destroy?
    user && user.id == record.user_id
  end

  def mark_best?
    unless record.best
      user && user.id == record.question.user_id
    end
  end
end