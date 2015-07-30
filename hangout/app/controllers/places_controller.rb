class PlacesController < ApplicationController

	def index 	 
	end

  def results
    # lat lng from user.js AJAX get request
    @lat = params[:lat]
    @long = params[:lng]
    term = params[:term]
    yelp_params = { term: term, limit: 2}
    coordinates = { latitude: @lat, longitude: @long }
    new_search = Yelp.client.search_by_coordinates(coordinates, yelp_params)

    render json: "this is where the Yelp search results will be"
  end

end


    #term2 = params.require(:user).permit(:business_name)