class GoogleMapApiService
  def conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end

  def geo_conn
    Faraday.new(url: 'https://nominatim.openstreetmap.org')
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def address_to_geocode(address)
    add = address.delete(',').split.map {|w| w + "+" }.join[0...-1]
    response = geo_conn.get("search?q=#{add}&format=json")
    parse_json(response)[0]
  end

  def nearbysearch(attributes)
    response = conn.get("search/v4/place?#{attributes}&key=#{ENV['mapquest_api_key']}")
    parse_json(response)
  end
end
