require 'rails_helper'

describe 'Mipoint Facade' do
  it 'returns the midpoint coords between to addresses', :vcr do
    address = "2300 Steele St, Denver, CO 80205, USA"
#    json_response = File.read('spec/fixtures/address_to_geocode.json')
#    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['google_api_key']}")
#    .to_return(status: 200, body: json_response, headers: {})

    midpoint = MidpointFacade.find_midpoint(address, address)
    expect(midpoint).to be_a(String)

    geocode = MidpointFacade.address_to_geocode(address)
    expect(geocode).to be_a(Hash)
    expect(geocode).to have_key(:lat)
    expect(geocode[:lat]).to be_a(Float)
    expect(geocode).to have_key(:lon)
    expect(geocode[:lon]).to be_a(Float)
  end
end
