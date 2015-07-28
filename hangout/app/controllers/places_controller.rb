class PlacesController < ApplicationController

	def index #create a search
		parameters = {term: 'food', limit: 10}
		client = Yelp::Client.new({ consumer_key: Rails.application.secrets[:YELP_CONSUMER_KEY],
                            consumer_secret: Rails.application.secrets[:YELP_CONSUMER_SECRET],
                            token: Rails.application.secrets[:YELP_TOKEN],
                            token_secret: Rails.application.secrets[:YELP_TOKEN_SECRET]
                         })
		new_search =  client.search('San Francisco', parameters)
		@result = new_search.businesses[0].name
		binding.pry
	end


end

# places GET    /places(.:format)          places#index
#            POST   /places(.:format)          places#create
#  new_place GET    /places/new(.:format)      places#new
# edit_place GET    /places/:id/edit(.:format) places#edit
#      place GET    /places/:id(.:format)      places#show
#            PATCH  /places/:id(.:format)      places#update
#            PUT    /places/:id(.:format)      places#update
#            DELETE /places/:id(.:format)      places#destroy