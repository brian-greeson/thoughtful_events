class TicketmasterService
  def events_by_genre_and_location(params)

    conn = Faraday.new(url: 'https://app.ticketmaster.com/discovery/v2') do |f|
      f.params['apikey'] = ENV['TICKETMASTER_API']
    end

    response = conn.get('events.json') do |req|
      req.params['classificationName'] = params[:genre]
      # req.params['keyword'] = params[:genre]
      req.params['city'] = params[:city]
      req.params['stateCode'] = params[:state]
    end

    json = JSON.parse(response.body)
  end
end
