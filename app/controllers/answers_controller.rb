class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :mark_best]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:update, :destroy, :mark_best]
  after_action :publish_answer, only: [:create]

  respond_to :js

  def mark_best
    @answer.mark_best #if current_user.author_of?(@answer.question)
    respond_with(@answer)
  end

  def create
    respond_with(@answer = @question.answers.create(answers_params))
    authorize @answer
  end

  def destroy
    @answer.destroy #if current_user.author_of?(@answer)
    respond_with(@answer)
  end

  def update
    @answer.update(answers_params) #if current_user.author_of?(@answer)
    respond_with(@answer)
  end

  private

  def answers_params
    params.require(:answer)
      .permit(:body, attachments_attributes: [:file, :id, :_destroy])
      .merge(user_id: current_user.id)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  def publish_answer
    return if @answer.errors.any?
    answer = AnswerPresenter.new(@answer).as(:broadcast)
    ActionCable.server.broadcast("question_#{@question.id}_answers", answer)
  end
end
