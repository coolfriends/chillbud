require 'pry'
require_relative './plugin'

module Chillbud::Plugins
  # TODO: Documentation
  class ReminderPlugin < Plugin
    # TODO: Documentation
    class Reminder
      # TODO: Documentation
      def initialize(username, time, reminder, event)
        @username = username
        @time = time
        @reminder = reminder
        @event = event
      end

      # TODO: Documentation
      def to_s
        "#{@time.strftime("%F %T")}: #{@reminder} @#{@username}"
      end

      # TODO: Documentation
      def remind
        @event.send_message(self.to_s)
      end

      # TODO: Documentation
      def remind?
        DateTime.now < @time
      end
    end

    # TODO: Documentation
    def initialize(**options)
      super
      @command = "reminder"
      @reminders = []
    end

    # TODO: Documentation
    def run(event)
      _, time, *msg = event.content.split

      *numeric, unit = time.split("")
      numeric = numeric.join.to_i

      case unit.downcase
      when "s"
        time_to_play = DateTime.now + numeric
      when "m"
        time_to_play = DateTime.now + (numeric * 60)
      when "h"
        time_to_play = DateTime.now + (numeric * 60 * 60)
      else
        return "Could not parse your time. Try like the following" +
               "```!reminder 60s This is my reminder. It goes off in 60 seconds.```\n" +
               "Choose from (s)econds, (m)inutes, and (h)ours."
      end

      username = event.author.username
      reminder = Reminder.new(username, time_to_play, msg.join(" "), event)
      @reminders.push(reminder)
      event.send_message("Saved your reminder: @#{username}. You will be reminded at #{time_to_play.strftime("%F %T")}")
    end

    # TODO: Documentation
    def on_refresh
      removed = []
      @reminders.each do |r|
        if r.remind?
          removed.push(r)
        end
      end

      return "" if removed.empty?
      removed.each do |reminder|
        reminder.remind
        @reminders.delete(reminder)
      end
    end
  end
end
