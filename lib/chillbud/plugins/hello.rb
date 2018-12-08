# frozen_string_literal: true

require_relative './plugin'

module Chillbud
  module Plugins
    # Plugin definition
    class HelloPlugin < Plugin
      def initialize
        @command = 'hello'
      end

      def run(event)
        "Hello, #{event.author.username}"
      end
    end
  end
end
