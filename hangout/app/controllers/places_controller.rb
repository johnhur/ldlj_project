class PlacesController < ApplicationController

	def index
	end

  # search is on same page as results, so only need one method
  def results
    # lat, lng, and term from user.js AJAX get request
    @lat = params[:lat]
    @long = params[:lng]
    term = params[:term]
    yelp_params = { term: term, limit: 5}
    coordinates = { latitude: @lat, longitude: @long }
    new_search = Yelp.client.search_by_coordinates(coordinates, yelp_params)
    render json: new_search
  end

end


    #term2 = params.require(:user).permit(:business_name)