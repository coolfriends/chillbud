require 'spec_helper'
require 'rack/test'
require_relative '../app'

ENV['RACK_ENV'] = 'test'



RSpec.describe 'ChillbudApp' do
  include Rack::Test::Methods

  def app
    ChillbudApp
  end

  let(:proper_params) { { discord_token: 'myfaketoken' } }
  context 'Start bot' do
    # TODO: Figure out how to properly mock jobs to prevent
    # NoMethodError in test case
    it 'should start a bot with a discord token' do
      post('api/v1/start', proper_params)
      expect(last_response.status).to eq(200)
    end
  end
end
