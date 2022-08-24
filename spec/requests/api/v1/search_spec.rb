require 'rails_helper'

RSpec.describe 'The search API' do
#  before
#  VCR.insert_cassette('translates_a_street')
#end
  it 'midpoints search', :vcr do
    # VCR.insert_cassette('The_search_API/midpoints_search', :record => :new_episodes)
    # allow(MidpointFacade).to receive(:find_midpoint).and_return("-104.99464955%2C39.74574405")
    params = {
      address_1: '1583 Newton St Denver CO',
      address_2: '2300 Steele St Denver CO',
      category: 'cafe'
    }.to_json
    get "/api/v1/search", params: { params: params }
    binding.pry

    expect(response).to be_successful
    locations = JSON.parse(response.body, symbolize_names: true)[:data]
    locations[0..4].each do |location|
      expect(location).to have_key(:id)
      expect(location[:id]).to be_a(String)

      expect(location).to have_key(:type)
      expect(location[:type]).to eq('location')

      expect(location).to have_key(:attributes)
      expect(location[:attributes].count).to eq(9)

      expect(location[:attributes]).to have_key(:id)
      expect(location[:attributes][:id]).to be_a(Integer)

      expect(location[:attributes]).to have_key(:name)
      expect(location[:attributes][:name]).to be_a(String)

      expect(location[:attributes]).to have_key(:place_id)
      expect(location[:attributes][:place_id]).to be_a(String)

      expect(location[:attributes]).to have_key(:address)
      expect(location[:attributes][:address]).to be_a(String)

      expect(location[:attributes]).to have_key(:lat)
      expect(location[:attributes][:lat]).to be_a(Float)

      expect(location[:attributes]).to have_key(:lng)
      expect(location[:attributes][:lng]).to be_a(Float)

      expect(location[:attributes]).to have_key(:rating)
      expect(location[:attributes][:rating]).to be_a(Float)

      expect(location[:attributes]).to have_key(:image_url)
      expect(location[:attributes][:image_url]).to be_a(String)

      expect(location[:attributes]).to have_key(:price_level)
      expect(location[:attributes][:price_level]).to be_in([nil,1,2,3,4])
    end
  end
end
