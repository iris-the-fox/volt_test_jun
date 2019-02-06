class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  set_pagination_headers :posts, only: [:index]


  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    #paginate(:page => params[:page], :per_page => params[:per_page], json: @posts)
    @posts = Post.all.paginate(:page => params[:page], :per_page => params[:per_page])
    render json: @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: api_v1_post_url(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published_at)
    end
end
