require_relative 'spec_helper'

describe 'root page page' do
  it 'can load the root path' do
    get '/'

    expect(last_response.body).to include('Thoughtful Events API')
  end
end
