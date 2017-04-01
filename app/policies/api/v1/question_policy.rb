# class Api::V1::QuestionPolicy < ApplicationPolicy
#   def show?
#     true
#   end
#
#   def create?
#     true
#   end
#
#   def update?
#     user && user.id == record.user_id
#   end
#
#   def destroy?
#     user && user.id == record.user_id
#   end
# end
