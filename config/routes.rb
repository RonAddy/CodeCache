Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'sessions#new'
  
  resources :users, only: [:new, :create, :index, :show]
  # new to render (GET) register/log-in form
  # create to (POST) new session_token for user
  # destroy (DELETE) to sign-out and delete session_token
  
  resource :session, only: [:new, :create,  :destroy]
end
