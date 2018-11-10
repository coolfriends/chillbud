require 'open_weather'
require 'chillbud/plugins/plugin'
require 'chillbud/format'

module Chillbud::Plugins
  # A plugin for obtaining forecasts from Open Weather Map.
  class WeatherPlugin < Plugin
    attr_accessor :api_token

    def initialize(weather_token = nil)
      @command = "weather"
      @usage = "weather [city]"
      @api_token = weather_token
      yield self if block_given?
      raise 'Missing weather token' unless @api_token
    end

    def register(bud)
      @bud = bud
      bud.bot.command(@command.to_sym, usage: @usage) do |event|
        city = event.message.content.split
        run(event, city)
      end
    end

    def run(event, city)
      event << "@#{event.author.username}, the current forecast for #{city} is:"
      print_weather(city)
    end

    def print_weather(city)
      format_weather(get_weather(city))
    end

    def get_weather(city)
      OpenWeather::Current.city(city, { units: "imperial", APPID: @api_token })
    end

    def format_weather(weather)
      now = Time.new
      date = now.strftime("%Y-%m-%d")
      time = now.strftime("%H:%M:%S")

      s = <<~HEREDOC
            Date: #{date}
            Time: #{time}
            Temperature: #{weather['main']['temp']}
          HEREDOC
      Chillbud::Format.blockify(s)
    end
  end
end
