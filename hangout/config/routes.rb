Rails.application.routes.draw do

  root 'sessions#login'
  get '/login', to: "sessions#login", as: 'login'
  post '/login', to: "sessions#attempt_login"
  delete '/logout', to: "sessions#logout", as: "logout"
  
  resources :users
  resources :places
end
