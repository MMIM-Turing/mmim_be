class LocationResponse
  @@instance_count = 0

  attr_reader :id,
  :name,
  :address,
  :lat,
  :lng


  def initialize(attr, yelp_data)
    binding.pry
    @id = @@instance_count += 1
    @name = attr[:name]
    @yelp_id = yelp_data[:id]
    @address = [attr[:place][:properties][:street], ", ", attr[:place][:properties][:city], ", ", attr[:place][:properties][:stateCode], ", ", attr[:place][:properties][:postalCode]].join
    @lat = attr[:place][:geometry][:coordinates][1]
    @lng = attr[:place][:geometry][:coordinates][0]
    #@rating = attr[:rating].to_f if attr[:rating]
    @image_url = yelp_data[:img_url]
    #@price_level = attr[:price_level].to_i if attr[:price_level]
  end

end
