class CommentsController < ApplicationController
  COMMENTABLE_TYPE = %w(answer question)
  before_action :authenticate_user!
  before_action :set_commentable!, only: [:create]
  after_action :publish_comment, only: [:create]

  def create
    if COMMENTABLE_TYPE.include?(@commentable_type)
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        render json: CommentPresenter.new(@comment).as(:success_create)
      else
        render_error(:unprocessable_entity, 'Error save', 'Not the correct comment data!')
      end
    else
      render_error(:forbidden, 'Error save', 'Not the correct comment data!')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable!
    @commentable_type = request.fullpath.split('/').second.singularize
    commentable_id = params["#{@commentable_type}_id"]
    @commentable = @commentable_type.classify.constantize.find(commentable_id)
  end

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "comments",
      comment: @comment,
      commentable_type: @comment.commentable_type.underscore
    )
  end
end
