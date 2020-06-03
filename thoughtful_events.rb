require 'faraday'
require 'sinatra/base'
require 'pry'

class ThoughtfulEvents < Sinatra::Base
  get '/' do
    'Thoughtful Events API'
  end

  get '/events' do
    content_type :json
  genres = params[:genres].split(',')
  genres.each do |genre|
    TicketmasterService.new.events_by_genre_and_location(
      {
        genre: genre,
        city: params[:city],
        state: params[:state]
      }
    )
  end
# old fixed response and format
# {
#   music: [{name: 'Eagles',
#     location: '100 Circle Dr',
#     genre: 'music',
#     date: '10/10/99' }]
# }.to_json
  end
end
