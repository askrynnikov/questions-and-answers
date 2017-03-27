RSpec.describe AnswersController, type: :controller do

  # let(:user) { create(:user) }
  # let(:question) { create(:question) }
  # let(:answer) { create(:answer, question: question, user: user) }

  let(:user_question_creater) { create(:user) }
  let(:question) { create(:question, user: user_question_creater) }
  let(:user_answer_creater) { create(:user) }
  let(:answer) { create(:answer, user: user_answer_creater, question: question) }
  let(:user_other) { create(:user) }

  describe 'POST #create' do
    before { sign_in user_other }

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect do
          post :create, params: {answer: attributes_for(:answer), question_id: question, format: :js}
        end.to change(question.answers, :count).by(1)
      end
      it 'render crate template' do
        post :create, params: {answer: attributes_for(:answer), question_id: question, format: :js}
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create, params: {answer: attributes_for(:invalid_answer), question_id: question, format: :js}
        end.to_not change(Answer, :count)

      end
      it 'render create template' do
        post :create, params: {answer: attributes_for(:invalid_answer), question_id: question, format: :js}
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      before { sign_in user_answer_creater }

      it 'assign the requested answer to @answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer), format: :js}
        expect(assigns(:answer)).to eq answer
      end

      it 'render update template' do
        patch :update, params: {id: answer, answer: attributes_for(:answer), format: :js}
        expect(response).to render_template :update
      end
    end

    context 'Non-authenticated user' do
      it 'try update answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer), format: :json}
        expect(assigns(:answer)).to_not eq answer
      end
    end
  end

  describe 'PATCH #mark_best' do
    context 'Authenticated user' do
      before { sign_in question.user }

      context 'asker' do
        before { patch :mark_best, params: { id: answer }, format: :js }
        it 'marks best answer' do
          expect(answer.reload).to be_best
        end

        it 'render template best' do
          expect(response).to render_template :mark_best
        end
      end

      context 'not asker' do
        # sign_in_user
        before { sign_in user_other }

        it 'marks best answer' do
          patch :mark_best, params: { id: answer }, format: :json
          expect(answer.reload).to_not be_best
        end
      end
    end

    context 'Non-authenticated user' do
      it 'marks best answer' do
        patch :mark_best, params: { id: answer }, format: :js
        expect(answer.reload).to_not be_best
      end
    end
  end
end
