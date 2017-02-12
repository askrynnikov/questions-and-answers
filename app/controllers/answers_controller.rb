class AnswersController < ApplicationController

  def new
    @answer = Answer.new
  end

end
