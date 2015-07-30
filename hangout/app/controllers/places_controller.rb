class PlacesController < ApplicationController

	def index 	 
	end

  def results
    # lat lng from user.js AJAX get request
    @lat = params[:lat]
    @long = params[:lng]
    lat_long = "#{params[:lat]}, #{params[:lng]}"
    # new_search =  Yelp.client.search('San Francisco', {term: 'food'})
		# @results = new_search.businesses[0].name
    binding.pry
    puts params

    render json: "this is where the Yelp search results will be"
  end

end