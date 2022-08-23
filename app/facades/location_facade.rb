class LocationFacade
  def self.service
    GoogleMapApiService.new
  end

  def self.get_near_by_locations(mid_coord, category)
    location_results = service.nearbysearch("location=#{mid_coord}&q=#{category}&sort=distance&feedback=false")
    x = location_results[:results].map do |location_result|
      LocationResponse.new(location_result)
    end
    binding.pry
  end
end



# https://www.mapquestapi.com/search/v4/place?location=-104.9504002621875%2C%2039.74924215&sort=distance&feedback=false&key=zlaZeUWUwDjy5iwTqIH9n1ljM0ZSGs7o&q=cafe
# mapquest wants lon, lat  and q=category
# note: longitude first!
