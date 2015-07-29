class PlacesController < ApplicationController

	def index 	 
	end

	def search
    coordinates = { latitude: params[:lat], longitude: params[:lng] }
    puts coordinates
  end

  def results

    # lat lng from user.js AJAX get request
    # binding.pry
    @lat = params[:lat]
    @long = params[:long]

    # new_search =  Yelp.client.search('San Francisco', {term: 'food'})
    new_search =  Yelp.client.search('San Francisco', {term: 'food'})
		@results = new_search.businesses[0].name
    
    binding.pry
    puts params

    render json: "this is where the Yelp search results will be"
  end

end