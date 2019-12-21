Rails.application.routes.draw do
  namespace :api, format: 'json' do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/auth/registrations'
      }
      get  '/mypage',   to: "users#index" 
      get  '/timeline', to: "posts#timeline"
      post '/posts', to: "posts#create"
      resources :relationships, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
