# app.rb
require 'roda'
require 'json'
require 'chillbud'
require_relative './lib/chillbud/jobs/chillbud_job'

class ChillbudApp < Roda
  plugin :json

  route do |r|
    # /api
    r.on 'api' do
      # /api/v1
      r.on 'v1' do
        # /api/v1/start
        r.on 'start' do
          r.post do
            j = JSON.parse r.body.read
            discord_token = j['discord_token']
            Chillbud::Jobs::ChillbudJob.perform_async(
              {
                action: :start,
                discord_token: discord_token,
              }
            )
            {
              message: "Successfully started bot",
              discord_token: discord_token
            }
          end
        end
        r.on 'stop' do
          r.post do
            j = JSON.parse r.body.read
            discord_token = j['discord_token']
            Chillbud::Jobs::ChillbudJob.perform_async(
              {
                action: :stop,
                discord_token: discord_token
              }
            )
            {
              message: "Successfully stopped bot",
              discord_token: discord_token
            }
          end
        end
      end
    end
  end
end
