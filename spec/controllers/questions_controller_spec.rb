RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: {id: question} }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: {question: attributes_for(:question)} }.to change(Question, :count).by(1)
      end
      it 'redirect to show view' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: {question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end
      it 're-renders new view' do
        post :create, params: {question: attributes_for(:invalid_question)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      sign_in_user

      it 'assign the requested question to @question' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js}
        expect(assigns(:question)).to eq question
      end

      it 'render update template' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js}
        expect(response).to render_template :update
      end
    end

    context 'Non-authenticated user' do
      it 'try update question' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js}
        expect(assigns(:question)).to_not eq question
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      question
    end
    it 'deletes question' do
      sign_in(user)
      expect { delete :destroy, params: {id: question} }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      sign_in(user)
      delete :destroy, params: {id: question}
      expect(response).to redirect_to questions_path
    end

    it 'the user can not remove is not his own question' do
      user2 = create(:user)
      sign_in(user2)
      expect { delete :destroy, params: {id: question} }.to_not change(Question, :count)
    end
  end
end
