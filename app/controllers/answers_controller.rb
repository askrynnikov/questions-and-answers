class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :mark_best, :destroy]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:update, :destroy, :mark_best]


  def mark_best
    @answer.mark_best if current_user.author_of?(@answer.question)
  end

  def create
      @answer = @question.answers.new(answers_params)
      @answer.user = current_user
      @answer.save
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  def update
    @answer.update(answers_params) if current_user.author_of?(@answer)
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
