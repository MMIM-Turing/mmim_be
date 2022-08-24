class LocationResponse
  @@instance_count = 0

  attr_reader :id,
  :name,
  :address,
  :url,
  :rating,
  :photos,
  :categories,
  :review_count,
  :price,
  :is_open_now

  def initialize(yelp_data)
    @id = @@instance_count += 1
    @name = yelp_data[:name]
    @url = yelp_data[:url]
    @photos = yelp_data[:photos].take(5)
    @categories = yelp_data[:categories].map { |cat| cat[:title] }.take(5)
    @review_count = yelp_data[:review_count]
    @price = yelp_data[:price]
    if yelp_data[:hours]
      @is_open_now = yelp_data[:hours][0][:is_open_now]
    else
      @is_open_now = nil
    end
    @address = yelp_data[:location][:display_address].join(", ")
    # @lat = attr[:place][:geometry][:coordinates][1]
    # @lng = attr[:place][:geometry][:coordinates][0]
    #@rating = attr[:rating].to_f if attr[:rating]
    # @image_url = yelp_data[:img_url]
    #@price_level = attr[:price_level].to_i if attr[:price_level]
  end

end
