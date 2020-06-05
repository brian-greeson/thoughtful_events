class TicketmasterSerializer
  def ingest(response)
    events = []
    if response['_embedded']
      response['_embedded']['events'].each { |event| events << event_details(event) }
    else
      events << no_events_message
    end
    events
  end

private

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

  def no_events_message
    {
      name: 'We are extremely sorry, but there are no events available within your search. Please try adjusting your requirements, life view, or trip expectations. Whatever is most convenient. Eat more tacos!',
      location: '',
      date: '',
      genre: ''
    }
  end
end
