# app.rb
require 'roda'
require 'json'
require 'chillbud'

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
            bud = Chillbud::Chillbud.new do |c|
              c.discord_token = discord_token
              c.add_plugin(Chillbud::Plugins::HelloPlugin.new)
            end
            bud.start
            {
              message: "Successfully started bot",
              discord_token: discord_token
            }
          end
        end
      end
    end
  end
end
