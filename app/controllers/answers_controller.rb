class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :mark_best, :destroy]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:update, :destroy, :mark_best]


  def mark_best
    @answer.mark_best if current_user && current_user.author_of?(@answer.question)
  end

  # def new
  #   # @answer = @question.answers.new
  # end

  def create
    # @question.answers.create(answers_params)
    if current_user
      @answer = @question.answers.new(answers_params)
      @answer.user = current_user
      @answer.save
    end
    # if @answer.save
    #   flash[:notice] = 'Your answer successfully created.'
    # else
    #   flash[:alert] = 'Your answer is not created.'
    # end
    # redirect_to @question
  end

  def destroy
    @answer.destroy if current_user && current_user.author_of?(@answer)

    # if current_user.author_of?(@answer)
    #   @answer.destroy
    #   flash[:notice] = 'Your answer successfully deleted.'
    # else
    #   flash[:alert] = 'Your are not author.'
    # end
    # redirect_to @answer.question
  end

  def update
    @answer.update(answers_params) # if current_user && current_user.author_of?(@answer)
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
