class AnswersController < ApplicationController
  before_action :set_question

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answers_params)

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
