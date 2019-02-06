class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{nickname}
  def show
    @user ? (render json: @user) : (render json: { errors: 'User not found' })
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{nickname}
  def update
    if @user.nil?
      render json: { errors: 'User not found' }, status: :not_found
    elsif !@user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{nickname}
  def destroy
    unless @user&.destroy
      render json: { errors: 'User not found' },
             status: :not_found
    end
  end

  private

  def find_user
    @user = User.find_by_nickname(params[:_nickname])
  end

  def user_params
    params.permit(:nickname, :email, :password)
  end
end
