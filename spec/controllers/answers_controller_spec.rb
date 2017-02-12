require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }

  describe 'GET #new' do
    before { get :new, params: { :question_id => answer.question_id } }

    it 'assigns a new Answer to @answer' do
      # answer1 = FactoryGirl.create(:answer)
      # get :new, params: { :question_id => answer1.question_id }
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end
end
