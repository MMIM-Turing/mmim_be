require 'rails_helper'

describe 'Location Facade' do
  it 'returns locations given a midpoint', :vcr do
#    json_response = File.open("./spec/fixtures/nearbysearch2.json")
#    stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV['google_api_key']}&location=39.7512038%2C-104.9447319&type=cafe&rankby=distance")
#    .to_return(status: 200, body: json_response)

    mid_coord = "-104.9504002621875%2C39.74924215"
  #  attributes = "location=#{mid_coord}&type=cafe&rankby=distance"
  #  json_response = File.read('spec/fixtures/nearbysearch.json')
#    stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?#{attributes}&key=#{ENV['google_api_key']}")
#    .to_return(status: 200, body: json_response, headers: {})

    location_results = LocationFacade.get_near_by_locations(mid_coord, "cafe")
    expect(location_results).to be_a(Array)
    expect(location_results.first).to be_a(LocationResponse)
  end
end
