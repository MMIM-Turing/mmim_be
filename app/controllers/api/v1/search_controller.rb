class Api::V1::SearchController < ApplicationController
  def index
    midpoint_coords = MidpointFacade.find_midpoint(search_params[:address_1], search_params[:address_2])
    locations = LocationFacade.get_near_by_locations(midpoint_coords, search_params[:category])[0..4]
    render json: LocationSerializer.new(locations)
  end

  private
  def search_params
    JSON.parse(params[:params], symbolize_names: true)
  end
end
