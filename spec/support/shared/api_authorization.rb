RSpec.shared_examples_for 'API Authenticable' do
  context 'unauthorized' do
    it 'returns 401 status if there is no access_token' do
      do_request
      expect(response).to have_http_status :unauthorized
    end

    it 'returns 401 status if access_token is invalid' do
      do_request(access_token: 'invalid_token')
      expect(response).to have_http_status :unauthorized
    end
  end
end

