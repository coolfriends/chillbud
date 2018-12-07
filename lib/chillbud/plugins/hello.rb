require_relative './plugin'

module Chillbud::Plugins
  class HelloPlugin < Plugin
    def initialize
      @command = "hello"
    end

    def run(event)
      "Hello, #{event.author.username}"
    end
  end
end
