require 'rails_helper'

describe ApiService do
  describe 'happy paths' do
    it 'can get lat and lng for a street address', :vcr do
      address = "2300 Steele St, Denver, CO 80205, USA"
#      json_response = File.read('spec/fixtures/address_to_geocode.json')
#      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['google_api_key']}")
#      .to_return(status: 200, body: json_response, headers: {})

      service = ApiService.new
      response = service.address_to_geocode(address)[:results]

      expect(response).to be_an(Array)
      expect(response[0][:geometry][:location]).to be_a(Hash)
      expect(response[0][:geometry][:location]).to have_key(:lat)
      expect(response[0][:geometry][:location][:lat]).to be_a(Float)
      expect(response[0][:geometry][:location]).to have_key(:lng)
      expect(response[0][:geometry][:location][:lng]).to be_a(Float)

    end

    it 'can get nearby locations given a midpoint', :vcr do
      mid_coord = "-104.9447319%2C39.7512038"
      attributes = "location=#{mid_coord}&q=cafe&sort=distance&feedback=false"
#      json_response = File.read('spec/fixtures/nearbysearch.json')
#      stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?#{attributes}&key=#{ENV['google_api_key']}")
#      .to_return(status: 200, body: json_response, headers: {})

      service = ApiService.new
      response = service.nearbysearch(attributes)[:results]

      expect(response).to be_an(Array)
      expect(response[0][:geometry][:location]).to be_a(Hash)
      expect(response[0][:geometry][:location]).to have_key(:lat)
      expect(response[0][:geometry][:location][:lat]).to be_a(Float)
      expect(response[0][:geometry][:location]).to have_key(:lng)
      expect(response[0][:geometry][:location][:lng]).to be_a(Float)
      expect(response[0]).to have_key(:name)
      expect(response[0][:name]).to be_a(String)
      expect(response[0]).to have_key(:place_id)
      expect(response[0][:place_id]).to be_a(String)
      expect(response[0]).to have_key(:vicinity)
      expect(response[0][:vicinity]).to be_a(String)
      expect(response[0]).to have_key(:rating)
      expect(response[0][:rating]).to be_a(Float)
    end

    it 'yelp', :vcr do
      lat = 39.74751
      lon = -104.940935
      term = "T-Rex Cafe"

      service = ApiService.new
      response = service.get_yelp_id(lat, lon, term)
    end
  end
end
