require_relative 'spec_helper'

describe 'ticketmaster api stuffs' do
  it 'can get events by location' do
    query_params = {
      genres: 'music,sports',
      city: 'Denver',
      state: 'CO'
    }
    musicstub = File.read('spec/fixtures/ticketmaster_music.json')
    stub_request(:get, 'https://app.ticketmaster.com/discovery/v2/events.json?apikey=9VxGzaXcajmAGvWV0Q3NYxP9sgNVXQct&classificationName=music&city=Denver&stateCode=CO').to_return(body: musicstub)
    # stub_request(:get, 'https://app.ticketmaster.com/discovery/v2/events.json?apikey=9VxGzaXcajmAGvWV0Q3NYxP9sgNVXQct&classificationName=sports&city=Denver&stateCode=CO').to_return(status: 405)
    get '/events', query_params

    response_json = JSON.parse(last_response.body, symbolize_names: true)
    first_music_event = response_json[:music].first
    # expect(first_music_event).to eq(
    #   {
    #     name: 'Eagles',
    #     location: '100 Circle Dr',
    #     genre: 'music',
    #     date: '10/10/99'
    #   }
    # )
  end
end
