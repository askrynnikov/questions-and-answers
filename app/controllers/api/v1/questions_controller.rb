class Api::V1::QuestionsController < Api::V1::BaseController
  after_action :load_authorize, except: :index

  def index
    @questions = Question.all
    respond_with(@questions, each_serializer: QuestionSerializer)
  end
end
