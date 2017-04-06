RSpec.describe SubscriptionsController, type: :controller do
  let(:user_subscription_creater) { create(:user) }
  let(:question) { create(:question) }
  let!(:subscription) { create(:subscription, user: user_subscription_creater, question: question) }
  let(:user_other) { create(:user) }

  describe 'POST #create' do
    let(:subscription_params) { { question_id: question, format: :js } }
    context 'Authenticated user' do
      before { sign_in user_other }

      context 'with valid attributes' do
        it 'saves the new subscription in the database' do
          expect { post :create, params: subscription_params }.to change(Subscription, :count).by(1)
        end

        it 'subscription belongs to the user' do
          post :create, params: subscription_params
          expect(Subscription.last.user).to eq user_other
        end

        it 'render template' do
          post :create, params: subscription_params
          expect(response).to render_template :create
        end
      end

      context 'double subscribe' do
        it 'tries subscribe again' do
          sign_in user_subscription_creater
          expect { post :create, params: subscription_params }.to_not change(Subscription, :count)
        end
      end
    end

    context 'Non-authenticated user' do
      it 'tries to subscribe' do
        expect do
          post :create, params: subscription_params
        end.to_not change(Subscription, :count)
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'Authenticated user' do
      context 'author subscription' do
        let(:subscription_params) { { id: subscription.id, format: :js } }
        before { sign_in user_subscription_creater }

        it 'delete subscription' do
          expect { delete :destroy, params: subscription_params }.to change(Subscription, :count).by(-1)
        end

        it 'render template' do
          delete :destroy, params: subscription_params
          expect(response).to render_template :destroy
        end
      end

      context 'not author subscription' do
        let(:subscription_params) { { id: subscription.id, format: :json } }
        before { sign_in user_other }

        it 'delete subscription' do
          expect { delete :destroy, params: subscription_params }.to_not change(Subscription, :count)
        end

        it 'render error' do
          delete :destroy, params: subscription_params
          expect(response).to have_http_status :unauthorized
        end
      end
    end

    context 'Non-authenticated user' do
      let(:subscription_params) { { id: subscription.id, format: :js } }
      it 'delete subscription' do
        expect { delete :destroy, params: subscription_params }.to_not change(Subscription, :count)
      end
    end
  end
end
