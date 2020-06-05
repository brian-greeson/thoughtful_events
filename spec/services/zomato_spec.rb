require './spec/spec_helper'

describe 'zomato api' do
  it 'can get a city id' do
    query_params = {
      genres: 'mexican,indian',
      city: 'Denver',
      state: 'CO'
    }

    expect(ZomatoService.new(query_params).city_id).to eq(305)
  end

  it 'can get restaurants by location' do
    query_params = {
      genres: 'mexican,indian',
      city: 'Denver',
      state: 'CO'
    }
    get '/events', query_params
    response_json = JSON.parse(last_response.body, symbolize_names: true)
    expect(response_json[:mexican].count).to eq(5)
    expect(response_json[:indian].count).to eq(5)
  end
end
