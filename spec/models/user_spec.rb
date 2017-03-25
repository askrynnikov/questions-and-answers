RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe '#author_of?' do
    it 'returns true' do
      user_id = rand(1..100)
      user = create(:user, id: user_id)
      entity = double('Entity')
      allow(entity).to receive_messages(user_id: user_id)
      expect(user.author_of?(entity)).to be_truthy
    end

    it 'returns false' do
      user_id = rand(1..100)
      other_id = rand(200..300)
      user = create(:user, id: user_id)
      entity = double('Entity')
      allow(entity).to receive_messages(user_id: other_id)
      expect(user.author_of?(entity)).to be_falsey
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:unconfirmed_user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'provider also returns email' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }

        context 'user already exists' do
          it 'does not create new user' do
            expect { User.find_for_oauth(auth) }.to_not change(User, :count)
          end

          it 'creates authorization for user' do
            expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
          end

          it 'creates authorization with provider and uid' do
            authorization = User.find_for_oauth(auth).authorizations.first

            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end

          it 'returns the user' do
            expect(User.find_for_oauth(auth)).to eq user
          end
        end

        context 'user does not exist' do
          let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@test.com' }) }

          it 'creates new user' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
          end

          it 'returns new user' do
            expect(User.find_for_oauth(auth)).to be_a(User)
          end

          it 'fills user email' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq auth.info.email
          end

          it 'creates authorization for user' do
            user = User.find_for_oauth(auth)
            expect(user.authorizations).to_not be_empty
          end

          it 'creates authorization with provider and uid' do
            authorization = User.find_for_oauth(auth).authorizations.first

            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end
        end
      end
    end
  end
end