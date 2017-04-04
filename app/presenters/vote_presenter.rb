class VotePresenter

  def as(presence)
    send("present_as_#{presence}")
  end

  def initialize(vote)
    @vote = vote
  end

  private

  def present_as_success_create
    @vote
      .slice(:id, :votable_id)
      .merge(votable_type: @vote.votable_type.underscore,
             votable_rating: @vote.votable.rating,
             action: 'create',
             message: 'Your vote has been accepted!')
  end

  def present_as_success_destroy
    @vote
      .slice(:id, :votable_id)
      .merge(votable_type: @vote.votable_type.underscore,
             votable_rating: @vote.votable.rating,
             action: 'delete',
             message: 'Your vote removed!')
  end
end
