class ApiService
  def mapquest_conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end

  def nominatim_conn
    Faraday.new(url: 'https://nominatim.openstreetmap.org')
  end

  def yelp_conn
    Faraday.new(url: 'https://api.yelp.com/v3/businesses') do |f|
      f.headers['Authorization'] = "Bearer " + ENV['yelp_api_key']
    end
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def address_to_geocode(address)
    add = address.delete(',').split.map {|w| w + "+" }.join[0...-1]
    response = nominatim_conn.get("search?q=#{add}&format=json")
    parse_json(response)[0]
  end

  def nearbysearch(attributes)
    response = mapquest_conn.get("search/v4/place?#{attributes}&key=#{ENV['mapquest_api_key']}")
    parse_json(response)
  end

  def get_yelp_id(lat, lon, name)
    url = "search?latitude=#{lat}&longitude=#{lon}&term=#{name}&limit=1"
    response = yelp_conn.get(url)
    parse_json(response)[:businesses][0][:id]
  end

  def get_yelp_data(id)
    url = id
    response = yelp_conn.get(url)
    parse_json(response)
  end
end
