class TicketmasterSerializer
  def ingest(response)
    events = []
    response["_embedded"]["events"].each do |event|
      location = {
        address: event["_embedded"]["venues"][0]["city"]["name"] + ',' + event["_embedded"]["venues"][0]["state"]["stateCode"],
        coordinates: event["_embedded"]["venues"][0]["location"]
      }
      events << {
        name: event["name"],
        location: location,
        date: event["dates"]["start"]["localDate"],
        genre: event["classifications"][0]["segment"]["name"]
      }
    end
    events
  end
end
