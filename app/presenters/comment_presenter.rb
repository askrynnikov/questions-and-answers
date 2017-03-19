class CommentPresenter

  def as(presence)
    send("present_as_#{presence}")
  end

  def initialize(comment)
    @comment = comment
  end

  private

  def present_as_success_create
    @comment.slice(:id, :commentable_id, :content)
      .merge(
        commentable_type: @comment.commentable_type.underscore,
        action: 'create',
        message: 'Your comment has been added!'
      )
  end
end
