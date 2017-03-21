class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :update, :destroy]
  before_action :build_answer, only: [:show]
  after_action :publish_question, only: [:create]

  respond_to :js, only: [:update]

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit; end

  def create
    respond_with(@question = current_user.questions.create(questions_params))
  end

  def update
    @question.update(questions_params) if current_user.author_of?(@question)
    respond_with @question
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    respond_with(@question)
  end

  private

  def flash_interpolation_options
    {resource_name: 'New awesome question', time: @question.created_at, user: current_user.email}
  end

  def build_answer
    @answer = @question.answers.build
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions', @question
      # ApplicationController.render(
      #   partial: 'questions/question',
      #   locals: { question: @question }
      # )
    )
  end
end
