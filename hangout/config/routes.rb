Rails.application.routes.draw do

  root 'sessions#login'
  get '/login', to: "sessions#login", as: 'login'
  post '/login', to: "sessions#attempt_login"
  delete '/logout', to: "sessions#logout", as: "logout"


	# root 'users#index'

	get '/search', to: 'users#search'
	# the AJAX get request from the user.js file is looking for
	# the results action here
	get '/results', to: 'users#results'


  resources :users
  resources :places
end

# Prefix Verb   URI Pattern                Controller#Action
#       root GET    /                          places#index
#     search GET    /search(.:format)          places#search
#      users GET    /users(.:format)           users#index
#            POST   /users(.:format)           users#create
#   new_user GET    /users/new(.:format)       users#new
#  edit_user GET    /users/:id/edit(.:format)  users#edit
#       user GET    /users/:id(.:format)       users#show
#            PATCH  /users/:id(.:format)       users#update
#            PUT    /users/:id(.:format)       users#update
#            DELETE /users/:id(.:format)       users#destroy
#     places GET    /places(.:format)          places#index
#            POST   /places(.:format)          places#create
#  new_place GET    /places/new(.:format)      places#new
# edit_place GET    /places/:id/edit(.:format) places#edit
#      place GET    /places/:id(.:format)      places#show
#            PATCH  /places/:id(.:format)      places#update
#            PUT    /places/:id(.:format)      places#update
#            DELETE /places/:id(.:format)      places#destroy
