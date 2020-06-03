require_relative 'spec_helper'

describe 'ticketmaster api stuffs' do
  it 'can get events by location' do
    query_params = {
      classificationName: 'music',
      city: 'Denver',
      stateCode: 'CO',
    }
    get '/events', query_params

    response_json = JSON.parse(last_response.body, symbolize_names: true)
    first_music_event = response_json[:music].first
    expect(first_music_event).to eq(
      {
        name: 'Eagles',
        location: '100 Circle Dr',
        genre: 'music',
        date: '10/10/99'
      }
    )
  end
end
