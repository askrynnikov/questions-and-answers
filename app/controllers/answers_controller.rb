class AnswersController < ApplicationController

  def new
    @answer = Answer.new
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end
