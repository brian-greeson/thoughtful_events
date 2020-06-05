require 'faraday'
require 'sinatra/base'
require './serializers/ticketmaster_serializer'
require './serializers/zomato_serializer'
require "pry"
class ThoughtfulEvents < Sinatra::Base
  get '/' do
    'Thoughtful Events API'
  end

  get '/events' do
    content_type :json
    responses = {}
    genres = params[:genres].split(',')

    genre_params(genres)[:food].each do |genre|
      response = ZomatoService.new(search_params(genre)).restaurants_by_genre_and_location
      responses[genre] = ZomatoSerializer.new.ingest(response)
    end

    genre_params(genres)[:events].each do |genre|
      response = TicketmasterService.new.events_by_genre_and_location(search_params(genre))
      responses[genre] = TicketmasterSerializer.new.ingest(response)
    end

    responses.to_json
  end

  def search_params(genre)
    {
      genre: genre,
      city: params[:city],
      state: params[:state]
    }
  end

  def genre_params(genres)
    {
      food: genres.select {|genre| food_genres.include?(genre)},
      events: genres.reject {|genre| food_genres.include?(genre)}
    }
  end

  def food_genres
    ["indian","mexican","pizza","italian","chinese","american"]
  end


end
