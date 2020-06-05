class ZomatoSerializer
  def ingest(response)
    restaurants = []
    if response['restaurants']
      response['restaurants'].each do |restaurant|
        restaurants << restaurant_details(restaurant['restaurant'])
      end
    else
      restaurants << no_restaurants_message
    end
    restaurants
  end

  def restaurant_details(restaurant)
    {
      name: restaurant['name'],
      location: restaurant['location']['address'],
      date: nil,
      genre: restaurant['cuisines']
    }
  end

  def no_restaurants_message
    {
      name: 'We are extremely sorry, but there are no restaurants available within your search. Please try adjusting your requirements, life view, or trip expectations. Whatever is most convenient. Eat more tacos!',
      location: '',
      date: '',
      genre: ''
    }
  end
end
