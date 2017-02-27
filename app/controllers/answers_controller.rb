class AnswersController < ApplicationController
  before_action :set_question

  def new
    @answer = @question.answers.new
  end

  def create
    # @question.answers.create(answers_params)
    @answer = @question.answers.new(answers_params)
    @answer.user = current_user
    @answer.save
    # if @answer.save
    #   flash[:notice] = 'Your answer successfully created.'
    # else
    #   flash[:alert] = 'Your answer is not created.'
    # end
    # redirect_to @question
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy if current_user.author_of?(@answer)

    # if current_user.author_of?(@answer)
    #   @answer.destroy
    #   flash[:notice] = 'Your answer successfully deleted.'
    # else
    #   flash[:alert] = 'Your are not author.'
    # end
    # redirect_to @answer.question
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answers_params)
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
