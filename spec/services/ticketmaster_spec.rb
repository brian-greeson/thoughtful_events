require './spec/spec_helper'

describe 'ticketmaster api' do
  it 'can get events by location' do
    query_params = {
      genres: 'music,sports',
      city: 'Denver',
      state: 'CO'
    }
    musicstub = File.read('spec/fixtures/ticketmaster_music.json')
    stub_request(:get, "https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{ENV['TICKETMASTER_API']}&classificationName=music&city=Denver&stateCode=CO").to_return(body: musicstub)
    stub_request(:get, "https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{ENV['TICKETMASTER_API']}&classificationName=sports&city=Denver&stateCode=CO").to_return(body: musicstub)
    get '/events', query_params

    response_json = JSON.parse(last_response.body, symbolize_names: true)
    expect(response_json[:music].count).to eq(20)
    expect(response_json[:music][0][:name]).to eq("Juanes: Mas Futuro Que Pasado")
    expect(response_json[:sports].count).to eq(20)
    expect(response_json[:sports][0][:name]).to eq("Juanes: Mas Futuro Que Pasado")
  end
end
