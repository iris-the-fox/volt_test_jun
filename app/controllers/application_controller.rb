class ApplicationController < ActionController::API
  before_action :authorize_request, except: :login
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'unauthorized' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  protected
    def self.set_pagination_headers(name, options = {})
      after_action(options) do |controller|
        results = instance_variable_get("@#{name}")
        headers["X-Total-Pages"] = results.total_pages
        headers["X-Total"] =  results.total_entries
      end
    end


end
