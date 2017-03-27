require_relative "../../lib/pandit/votable_context"

class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_votable!, only: [:create]

  def pundit_user
    VotableContext.new(current_user, @votable)
  end

  def create
    if !current_user.author_of?(@votable) &&
      @votable.vote_user(current_user).nil? &&
      %w(up down).include?(params[:rating])
      @vote = @votable.send("vote_#{params[:rating]}", current_user)
      if @vote.persisted?
        render json: VotePresenter.new(@vote).as(:success_create)
      else
        render_error(:unprocessable_entity, 'Error save', 'Not the correct vote data!')
      end
    else
      render_error(:forbidden, 'Error save', 'You can not vote')
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    authorize vote
    # if current_user.author_of?(vote)
      vote.destroy
      render json: VotePresenter.new(vote).as(:success_destroy)
    # else
    #   render_error(:forbidden, 'Error remove', 'You can not remove an vote!')
    # end
  end

  private

  def set_votable!
    # binding.pry
    votable_type = request.fullpath.split('/').second.singularize
    votable_id = params["#{votable_type}_id"]
    @votable = votable_type.classify.constantize.find(votable_id)
    authorize @votable
  rescue NoMethodError, NameError
    render_error(:bad_request, 'Error', 'Not the correct vote data!')
  end
end
