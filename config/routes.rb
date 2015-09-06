Rails.application.routes.draw do
  root to: 'events#index'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :users, only: :create
  resources :categories, only: :show
  resources :events, only: :show
end
