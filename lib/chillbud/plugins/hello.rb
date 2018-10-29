require 'chillbud/plugins/plugin'

module Chillbud::Plugins
  class HelloPlugin < Plugin
    @@command = "hello"

    def run(event)
      "Hello, #{event.author.username}"
    end
  end
end
