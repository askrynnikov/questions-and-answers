RSpec.shared_examples_for 'Create Comment' do
  let(:commentable_params) { Hash["#{commentable.class.name.underscore}_id", commentable.id] }
  let!(:comment_params) { commentable_params.merge(comment: attributes_for(:comment), format: :json) }

  context 'Authenticated user' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new comment in the database' do
        expect do
          post :create, params: comment_params
        end.to change(commentable.comments, :count).by(1)
      end

      it 'comment belongs to the user' do
        post :create, params: comment_params
        expect(Comment.last.user).to eq @user
      end

      it 'render comment serialized json schema' do
        post :create, params: comment_params
        expect(response).to have_http_status :success
        expect(response).to match_response_schema('comment')
      end

      it 'render success json' do
        post :create, params: comment_params
        comment = commentable.comments.last

        expect(response).to have_http_status :success

        response_data = %({"id": #{ comment.id },
                     "content": "#{ comment.content }",
                     "commentable_type": "#{ commentable.class.name.underscore }",
                     "commentable_id": #{ commentable.id },
                     "message": "Your comment has been added!",
                     "action": "create"})
        expect(response.body).to be_json_eql(response_data)
      end
    end

    context 'with invalid attributes' do
      let!(:invalid_comment_params) { commentable_params.merge(comment: { content: 'text' }, format: :json) }
      it 'does not save the comment' do
        expect do
          post :create, params: invalid_comment_params
        end.to_not change(Comment, :count)
      end

      it 'render error json' do
        post :create, params: invalid_comment_params
        data = JSON.parse(response.body)
        expect(response).to have_http_status :unprocessable_entity
        expect(response).to match_response_schema('error')
        expect(data['error']).to eq 'Error save'
        expect(data['error_message']).to eq 'Not the correct comment data!'
      end
    end
  end

  context 'Non-authenticated user' do
    it 'tries to comment' do
      expect do
        post :create, params: comment_params
      end.to_not change(Comment, :count)
    end
  end
end