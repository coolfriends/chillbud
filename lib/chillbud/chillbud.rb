require 'discordrb'

module Chillbud
  class Chillbud
    attr_accessor :discord_token
    attr_accessor :prefix

    def initialize(discord_token = nil, prefix = "!")
      @discord_token = discord_token
      @prefix = prefix
      @plugins = {}
      @bot = nil
      yield self if block_given?
    end

    def add_plugin(plugin)
      @plugins[plugin.command_suffix] = plugin
    end

    def start
      @bot = Discordrb::Bot.new token: @discord_token
      @plugins.each { |_, plugin| plugin.register(self) }
      @bot.run
    end
  end
end
