require './spec/spec_helper'

describe 'zomato api' do
  it 'can get restaurants by location' do
    query_params = {
      genres: 'mexican,indian',
      city: 'Denver',
      state: 'CO'
    }
    city_response = File.read('spec/fixtures/city.json')
    mexican_response = File.read('spec/fixtures/mexican.json')
    indian_response = File.read('spec/fixtures/indian.json')
    stub_request(:get, "https://developers.zomato.com/api/v2.1/cities?count=1&q=Denver,%20CO").to_return(body: city_response)
    stub_request(:get, "https://developers.zomato.com/api/v2.1/search?count=5&cuisines=73&entity_id&entity_type=city&radius=10000").to_return(body: mexican_response)
    stub_request(:get, "https://developers.zomato.com/api/v2.1/search?count=5&cuisines=148&entity_id&entity_type=city&radius=10000").to_return(body: indian_response)

    get '/events', query_params

    response_json = JSON.parse(last_response.body, symbolize_names: true)

    expect(response_json[:mexican].count).to eq(5)
    expect(response_json[:indian].count).to eq(5)
  end
end
