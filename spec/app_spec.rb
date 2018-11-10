require 'spec_helper'

describe 'ChillbudApp' do
  let(:proper_params) { { discord_token: myfaketoken } }
  context 'Start bot' do
    it 'should start a bot with a discord token' do
      post 'api/v1/start', proper_params
      expect(last_response.status).to eq(200)
    end
  end
end
