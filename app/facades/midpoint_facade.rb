class MidpointFacade
  def self.service
    ApiService.new
  end

  def self.address_to_geocode(address)
    data = service.address_to_geocode(address)
    { lat: data[:lat].to_f, lon: data[:lon].to_f }
  end

  def self.find_midpoint(add_1, add_2)
    coord_1 = address_to_geocode(add_1)
    coord_2 = address_to_geocode(add_2)
    midpoint_coords = "#{(coord_1[:lon] + coord_2[:lon])/2}%2C#{(coord_1[:lat] + coord_2[:lat])/2}"
  end
end
