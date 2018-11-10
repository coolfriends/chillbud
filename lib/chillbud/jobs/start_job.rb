require "sucker_punch"
require "chillbud"

module Chillbud
  module Jobs
    class StartJob
      include SuckerPunch::Job

      def perform(data)
        token = data[:discord_token]
        bud = Chillbud.new do |c|
          c.discord_token = token
          c.add_plugin(Plugins::HelloPlugin.new)
        end
        bud.start
      end
    end
  end
end
