require 'discordrb'
require 'pry'

module Chillbud
  class Chillbud
    attr_reader :discord_token
    attr_reader :bot
    attr_accessor :prefix

    # TODO: Documentation
    def initialize(discord_token = nil, prefix = "!")
      @discord_token = discord_token
      @prefix = prefix
      @plugins = {}
      @bot = Discordrb::Commands::CommandBot.new(
        token: @discord_token,
        prefix: @prefix
      )
      @refresh_interval = 5
      yield self if block_given?
    end

    # TODO: Documentation
    def plugin(sym)
      klass = case sym
              when :hello then Plugins::HelloPlugin
              when :reminder then Plugins::ReminderPlugin
              end
      add_plugin(klass.new)
    end

    # TODO: Documentation
    def add_plugin(plugin)
      @plugins[plugin.command] = plugin
      plugin.register(self)
    end

    # TODO: Documentation
    def start
      @bot.run(async: :async)

      while true
        on_refresh
        puts "Refreshing..."
        sleep @refresh_interval
      end
    end

    # TODO: Documentation
    def stop
      @bot.stop
    end

    # TODO: Documentation
    def on_refresh
      @plugins.each_value { |p| p.on_refresh if p.respond_to?(:on_refresh) }
    end
  end
end
