class ZomatoService
  def initialize(search_params)
    @city = search_params[:city]
    @state = search_params[:state]
    @genre = search_params[:genre]
    @food_genres = {
      american: 1,
      mexican: 73,
      italian: 55,
      taco: 997,
      indian: 148,
      pizza: 82,
      burger: 168,
      chinese: 25,
      bbq: 193,
      bakery: 5,
      bagels: 955,
      asian: 3,
      vegetarian: 308
      }
  end

  def restaurants_by_genre_and_location
    city = city_id
    response = conn.get('search') do |search|
      search.params['entity_id'] = city
      search.params['entity_type'] = 'city'
      search.params['radius'] = "10000"
      search.params['cuisines'] = cuisine_id
      search.params['count'] = "5"
    end
    JSON.parse(response.body, serialize_names: true)
  end

  def city_id
    response = conn.get('cities') do |c|
      c.params['q'] = cityname
      c.params['count'] = 1
    end
    json = JSON.parse(response.body, symbolize_names: true)
    json[:location_suggestions].first[:id]
  end

  def cuisine_id
    @food_genres[@genre.to_sym]
  end

  def cityname
    "#{@city}, #{@state}"
  end

  def conn
    Faraday.new(url: 'https://developers.zomato.com/api/v2.1') do |f|
      f.headers['user-key'] = ENV['ZOMATO']
    end
  end
end
