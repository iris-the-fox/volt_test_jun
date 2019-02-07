require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe 'any action' do
    context 'when user not authorised' do
      it 'should return error message' do
        resp = post :create
        expect(JSON.parse(resp.body)['error']).to eq('unauthorized')
      end
    end
  end

  before (:all) do
    @user = create(:user)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  let(:correct_create_post)   { {params: 
                                {post: {title: 'example title', body: 'example body', published_at: Time.now }}
                              }}
  let(:incorrect_create_post) { {params: 
                                {post: {title: 'example title'}}
                              }}


  describe 'post create' do
    context 'when user authorised' do
      it 'should return error message and 422 Unprocessable Entity status' do
        request.headers["Authorization"] = @token
        resp = post :create, incorrect_create_post
        expect(response.status).to eq 422
        expect(JSON.parse(resp.body)).to eq({"body"=>["can't be blank"]})

      end

      it 'should return created post and 201 Created status' do
        request.headers["Authorization"] = @token
        resp = post :create, correct_create_post
        expect(response.status).to eq 201
        expect(JSON.parse(resp.body)['id']).to_not be_nil
        expect(JSON.parse(resp.body)['title']).to eq('example title')
        expect(JSON.parse(resp.body)['body']).to eq('example body')
        expect(JSON.parse(resp.body)['author_nickname']).to eq(@user.nickname)
      end
    end
  end

  before (:all) do
    @posts = create_list(:post, 10)
  end

  let(:show_post) { {params: {id: @posts.last.id}}}
  let(:index_post) { {params: {page: 1, per_page: 10}}}

  
  describe 'post show' do
    context 'when user authorised' do
     

      it 'should return post and 200 OK status' do
        request.headers["Authorization"] = @token
        resp = get :show, show_post
        expect(response.status).to eq 200
        expect(JSON.parse(resp.body)['title']).to eq(@posts.last.title)
      end
    end
  end

  describe 'posts index' do

    it 'should return correct list of posts and 200 OK status' do
      request.headers["Authorization"] = @token
      resp = get :index, index_post
      expect(response.status).to eq 200
      expect(JSON.parse(resp.body).count).to eq(10)
    end
  end
end
