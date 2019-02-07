Rails.application.routes.draw do
  
  namespace 'api' do
    namespace 'v1' do
      resources :posts
      resources :comments
    end
  end

  resources :users, param: :_nickname
  post 'auth_login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'

end
