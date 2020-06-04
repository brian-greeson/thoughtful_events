class TicketmasterService
  def events_by_genre_and_location(params)
    JSON.parse(event_query(params).body)
  end

  private

  def conn
    Faraday.new(url: 'https://app.ticketmaster.com/discovery/v2') do |f|
      f.params['apikey'] = ENV['TICKETMASTER_API']
    end
  end

  def event_query(params)
    conn.get('events.json') do |req|
      req.params['classificationName'] = params[:genre]
      req.params['city'] = params[:city]
      req.params['stateCode'] = params[:state]
    end
  end
end
