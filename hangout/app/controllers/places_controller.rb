class PlacesController < ApplicationController

	def index #create a search
		new_search =  Yelp.client.search('San Francisco', {term: 'food'})
		@results = new_search.businesses[0].name
	 
	end


end