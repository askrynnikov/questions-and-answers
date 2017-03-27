class VotableContext
  attr_reader :user, :votable

  def initialize(user, votable)
    @user = user
    @votable = votable
  end
end
