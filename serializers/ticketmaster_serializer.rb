class TicketmasterSerializer
  def ingest(response)
    events = []
    if response['_embedded']
      response['_embedded']['events'].each do |event|
      events << event_details(event)
      end
    else
      events << {
        name: 'We are extreamly sorry, but there are no events availalbe within your search. Please try adjusting your requirements, life view, or trip expectations. Whatever is most convienent. Try Tacos',
        location: '',
        date: '',
        genre: ''
      }
    end
    events
  end

  def location(event)
    {
      address: event['_embedded']['venues'][0]['city']['name'] + ',' + event['_embedded']['venues'][0]['state']['stateCode'],
      coordinates: event['_embedded']['venues'][0]['location']
    }
  end

  def event_details(event)
    {
      name: event['name'],
      location: location(event),
      date: event['dates']['start']['localDate'],
      genre: event['classifications'][0]['segment']['name']
    }
  end
end
