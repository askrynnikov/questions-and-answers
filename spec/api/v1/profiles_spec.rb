RSpec.describe 'Profile API' do
  describe 'GET /profiles/me' do
    context 'unauthorized' do
      it 'returns 401 status if ther is no access_token' do
        get '/api/v1/profiles/me', params: { format: :json }
        expect(response).to have_http_status :unauthorized
      end

      it 'returns 401 status if ther is access_token is invalid' do
        get '/api/v1/profiles/me', params: { format: :json, access_token: '123' }
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  describe 'GET /profiles' do
    context 'unauthorized' do
      it 'returns 401 status if ther is no access_token' do
        get '/api/v1/profiles', params: { format: :json }
        expect(response).to have_http_status :unauthorized
      end

      it 'returns 401 status if ther is access_token is invalid' do
        get '/api/v1/profiles', params: { format: :json, access_token: '123' }
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:users) { create_list(:user, 2) }

      before { get '/api/v1/profiles', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it "contains users" do
        expect(response.body).to be_json_eql(users.to_json)
      end

      it "contains users expect not include me" do
        JSON.parse(response.body).each do |item|
          expect(item[:id]).to_not eq me.id
        end
      end

      it "contains present number users" do
        expect(response.body).to have_json_size(users.size)
      end
    end
  end
end