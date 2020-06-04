require 'faraday'
require 'pry'
require 'sinatra/base'
require './serializers/ticketmaster_serializer'

class ThoughtfulEvents < Sinatra::Base
  get '/' do
    'Thoughtful Events API'
  end

  get '/events' do
    content_type :json
    genres = params[:genres].split(',')
    responses = {}
    genres.each do |genre|
      response = TicketmasterService.new.events_by_genre_and_location(
        {
          genre: genre,
          city: params[:city],
          state: params[:state]
        }
      )
      responses[genre] = TicketmasterSerializer.new.ingest(response)
    end
    responses.to_json
  end
end
