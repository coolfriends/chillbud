require 'discordrb'
require 'pry'

module Chillbud
  # A buddy for your Discord channel with tons of plugins.
  #
  # The simplest example:
  #
  #   my_token = "mytokenthatishouldntstoreincode"
  #   bud = Chillbud::Chillbud.new(my_token)
  #   bud.plugin :hello
  #
  # Obtain Discord token from an enviornment variable and configure
  # using a block:
  #
  #   bud = Chillbud::Chillbud.new(ENV["DISCORD_TOKEN"]) do |b|
  #     b.plugin :hello
  #     b.plugin :reminder
  #   end
  #   bud.start
  #
  class Chillbud
    attr_reader :discord_token
    attr_reader :bot
    attr_accessor :prefix

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

    # Factory to create a plugin based on a symbol.
    #
    # Does nothing if the specified plugin does not exist.
    def plugin(sym)
      klass = case sym
              when :hello then Plugins::HelloPlugin
              when :reminder then Plugins::ReminderPlugin
              else return
              end
      add_plugin(klass.new)
    end

    # Register this instance with a plugin.
    #
    # This is an implementation of the Observer pattern where
    # the observer is Chillbud::Chillbud and the listeners are the
    # individual plugins. https://en.wikipedia.org/wiki/Observer_pattern
    def add_plugin(plugin)
      @plugins[plugin.command] = plugin
      plugin.register(self)
    end

    # Start the bot and execute the :on_refresh hook on a set interval.
    def start
      @bot.run(async: :async)

      while true
        run_hooks :on_refresh
        puts "Refreshing..."
        sleep @refresh_interval
      end
    end

    # Stop the bot.
    def stop
      @bot.stop
    end

    # Execute the hook for every plugin.
    def run_hooks(sym)
      @plugins.each_value(sym)
    end
  end
end
