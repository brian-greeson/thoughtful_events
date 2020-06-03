require 'sinatra'
require 'pry'

get '/events' do
  content_type :json

  {
    music: [{name: 'Eagles',
      location: '100 Circle Dr',
      genre: 'music',
      date: '10/10/99' }]
  }.to_json
end

# url: https://app.ticketmaster.com/discovery/v2/
# events.json?apikey={apikey}
