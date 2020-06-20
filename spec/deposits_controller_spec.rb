require_relative 'spec_helper'

describe DepositsController do
  it 'responds with a status 200' do
    get '/'
    expect(last_response.status).to eq(200)
  end
end
