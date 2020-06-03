require "sinatra"
require "faker"
require 'pry'


get '/events' do
  genres = ["mexican","italian","sports","music","french"]
  # genres = params[:genres]
  response = { genres: Hash.new { |hash, key| hash[key] = [] } }

  genres.each do |genre|
    5.times do
      response[:genres][genre] << {
      name: Faker::Restaurant.name,
      date:  Faker::Date.forward(days: rand(5..10)),
      location: Faker::Address.street_address,
      genre: genre
      }
    end
  end
  response.to_json
end
