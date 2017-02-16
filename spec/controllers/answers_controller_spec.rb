RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let!(:create_answer) do
    Proc.new do |question_id = question.id, params: attributes_for(:answer)|
      post :create, params: params.merge!(question_id: question_id)
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: answer.question_id } }

    it 'assigns a new Answer to @answer' do
      # answer = FactoryGirl.create(:answer)
      # get :new, params: { question_id: answer.question_id }
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { answer }

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect {
          create_answer.call(params: {answer: attributes_for(:answer)})
          # post :create, params: { answer: attributes_for(:answer), question_id: question.id }
        }.to change(Answer, :count).by(1)
      end
      it 'redirect to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: answer.question_id }
        expect(response).to redirect_to answer.question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: answer.question_id } }.to_not change(Answer, :count)
      end
      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: answer.question_id }
        expect(response).to render_template :new
      end
    end
  end
end
