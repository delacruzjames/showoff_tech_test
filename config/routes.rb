Rails.application.routes.draw do
  root 'pages#index'
  match "/dashboard", to: 'dashboard#index', via: [:get, :post]
  resources :users, only: [:index, :create, :update] do
    collection do
      get :me
      post :change_password
      post :reset_password
      post :refresh_token
    end
  end
  resources :sessions, only: :create
  resources :widgets, only: [:create, :update, :destroy]
  match '/sign_out', to: 'sessions#destroy', via: [:get, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
