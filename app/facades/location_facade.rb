class LocationFacade
  def self.service
    ApiService.new
  end

  def self.get_near_by_locations(mid_coord, category)
    location_results = service.nearbysearch("location=#{mid_coord}&q=#{category}&sort=distance&feedback=false")[:results]
    x = location_results.map do |location_result|
      lat = location_result[:place][:geometry][:coordinates][1]
      lon = location_result[:place][:geometry][:coordinates][0]
      term = location_result[:name]
      yelp_id = service.get_yelp_id(lat, lon, term)
      yelp_data = service.get_yelp_data(yelp_id)
      LocationResponse.new(location_result, yelp_data)
    end
    binding.pry
  end
end



# https://www.mapquestapi.com/search/v4/place?location=-104.9504002621875%2C%2039.74924215&sort=distance&feedback=false&key=zlaZeUWUwDjy5iwTqIH9n1ljM0ZSGs7o&q=cafe
# mapquest wants lon, lat  and q=category
# note: longitude first!
