require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'Get users' do
    context 'when user not authorised' do
      it 'should return error message' do
        resp = get :index
        expect(JSON.parse(resp.body)['error']).to eq('unauthorized')
      end
    end
  end

  before (:all) do
    @user = create(:user)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  let(:valid_create_user)   { {params: 
                                {nickname: 'example name', email: 'example@email.com', password: "qwerty" }
                              }}
  let(:invalid_create_user) { {params: 
                                {nickname: 'example name for invalid user'}
                              }}


  describe 'user create' do
    context 'when user authorised' do
      it 'should return error message and 422 Unprocessable Entity status' do
        request.headers["Authorization"] = @token
        resp = post :create, invalid_create_user
        expect(response.status).to eq 422
        expect(JSON.parse(resp.body)['errors']).to eq(["Password can't be blank", "Email can't be blank"])

      end

      it 'should return created user and 201 Created status' do
        request.headers["Authorization"] = @token
        resp = post :create, valid_create_user
        expect(response.status).to eq 201
        expect(JSON.parse(resp.body)['id']).to_not be_nil
        expect(JSON.parse(resp.body)['nickname']).to eq('example name')
        expect(JSON.parse(resp.body)['email']).to eq('example@email.com')
      end
    end
  end

end
