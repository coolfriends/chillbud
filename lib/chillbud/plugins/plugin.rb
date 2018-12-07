module Chillbud::Plugins
  # Base class for a Chillbud plugin.
  # Overload @@command with the name of the plugin (what will)
  # be used to call the plugin.
  # Over
  class Plugin
    # This needs to be overridden in subclasses. If the command is
    # "hello" and prefix is "!", you will call the command with
    # "!hello".
    attr_reader :command

    def initialize(**options)
      @bud = nil
      @command = nil
    end

    # Register this plugin to respond to a command.
    def register(bud)
      @bud = bud
      bud.bot.command(@command.to_sym) do |event|
        run(event)
      end
    end
  end
end
