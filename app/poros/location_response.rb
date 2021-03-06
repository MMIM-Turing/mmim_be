class LocationResponse
  @@instance_count = 0

  attr_reader :id,
  :name,
  :place_id,
  :address,
  :lat,
  :lng,
  :rating,
  :image_url,
  :price_level

  def initialize(attr)

    @id = @@instance_count += 1
    @name = attr[:name]
    @place_id = attr[:place_id]
    @address = attr[:vicinity]
    @lat = attr[:geometry][:location][:lat]
    @lng = attr[:geometry][:location][:lng]
    @rating = attr[:rating].to_f if attr[:rating]
    @image_url = attr[:photos].first[:photo_reference] if attr[:photos]
    @price_level = attr[:price_level].to_i if attr[:price_level]
  end

end
