Rails.application.routes.draw do
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/events', to: 'events#index'
  
  resources :events, only: :show
end
