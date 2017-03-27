class VotePolicy < ApplicationPolicy
  attr_reader :user, :record, :votable

  def initialize(context, record)
    @user = context.user
    @votable = context.votable
    @record = record
  end

  def create?
    # binding.pry
    # votable_type = request.fullpath.split('/').second.singularize
    # votable_id = params["#{votable_type}_id"]
    # @votable = votable_type.classify.constantize.find(votable_id)
    !user.author_of?(@votable)
  rescue NoMethodError, NameError
    false
  # user && user.id != record.user_id
  end

  def destroy?
    user && user.id == record.user_id
  end
end
