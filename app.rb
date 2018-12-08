# app.rb
require 'chillbud'
require 'json'
require 'roda'
require_relative './lib/chillbud/jobs/chillbud_job'

# Request routing tree child class
class ChillbudApp < Roda
  # Roda plugin initializations:
  # https://github.com/jeremyevans/roda/tree/master/lib/roda/plugins
  plugin :json

  # Start/Stop request route
  route do |r|
    # /api
    r.on 'api' do
      # /api/v1
      r.on 'v1' do
        # /api/v1/start
        r.on 'start' do
          r.post do
            @discord_token = r.params.fetch('discord_token')
            Chillbud::Jobs::ChillbudJob.perform_async(
              action: :start,
              discord_token: @discord_token
            )
            {
              message: 'Successfully started bot',
              discord_token: @discord_token
            }
          end
        end
        r.on 'stop' do
          r.post do
            @discord_token = r.params.fetch('discord_token')
            Chillbud::Jobs::ChillbudJob.perform_async(
              action: :stop,
              discord_token: @discord_token
            )
            {
              message: 'Successfully stopped bot',
              discord_token: @discord_token
            }
          end
        end
      end
    end
  end
end
