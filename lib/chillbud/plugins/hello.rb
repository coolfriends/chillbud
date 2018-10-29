module Chillbud::Plugins
  class HelloPlugin
    attr_accessor :command_suffix
    attr_accessor :name

    def initialize
      @bud = nil
      @command_suffix = "hello"
    end
    alias name command_suffix

    def command
      return @bud.prefix + @command_suffix if @bud
      @command_suffix
    end

    def register(bud)
      @bud = bud
      bud.message(content: command) do |event|
        run(event)
      end
    end

    def run(event)
      event.respond "Hello, #{event.author}"
    end
  end
end
