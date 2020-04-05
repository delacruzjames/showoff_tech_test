Rails.application.routes.draw do
  root 'pages#index'
  match "/dashboard", to: 'dashboard#index', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
