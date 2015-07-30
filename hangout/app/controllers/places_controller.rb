class PlacesController < ApplicationController

	def index 	 
	end

  def results
    # lat lng from user.js AJAX get request
    @lat = params[:lat]
    @long = params[:lng]
    term = params[:term]
    yelp_params = { term: term, limit: 2, offset: 5, sort: 1}
    coordinates = { latitude: @lat, longitude: @long }
    new_search = Yelp.client.search_by_coordinates(coordinates, yelp_params)
    # TODO - refactor into a separate function
    new_search.businesses.each do |business|
    	  result_name = business.name
    	  result_address = business.location.address
    	  result_lat = business.location.coordinate.latitude
    	  result_long = business.location.coordinate.longitude
    	  # result_review = business.review_count
    	  # result_rating = business.rating
        end 

    render json: "this is where the Yelp search results will be"
  end

end


    #term2 = params.require(:user).permit(:business_name)