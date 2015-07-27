Rails.application.routes.draw do

  get 'sessions/signup'

  get 'sessions/login'

  get 'sessions/home'

  resources :users
  resources :places
end
