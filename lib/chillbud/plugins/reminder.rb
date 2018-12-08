require 'pry'
require_relative './plugin'

module Chillbud
  module Plugins
    # Plugin that allows one to set reminders.
    #
    # It uses two methods to remind users: #run and #on_refresh.
    # The #run method captures a reminder from a user. The #on_refresh
    # method is called on an interval.
    class ReminderPlugin < Plugin
      # A reminder that goes off at a later time.
      Reminder = Struct.new(:username, :dt, :message, :event) do
        def to_s
          "#{dt.strftime('%F %T')}: #{message} @#{username}"
        end

        # Send a reminder.
        def remind
          event.send_message(to_s)
        end

        # Returns true if it is time to send the reminder.
        def remind?
          DateTime.now < dt
        end
      end

      def initialize(**options)
        super
        @command = 'reminder'
        @reminders = []
      end

      # Capture a reminder.
      def run(event)
        # Discard the command and capture the time string and reminder message.
        _, time, *msg = event.content.split
        *numeric, unit = time.split('')
        numeric = numeric.join.to_i

        # Calculate future reminder time in seconds.
        case unit.downcase
        when 's'
          time_to_play = DateTime.now + numeric
        when 'm'
          time_to_play = DateTime.now + (numeric * 60)
        when 'h'
          time_to_play = DateTime.now + (numeric * 60 * 60)
        else
          event.send_message(
            'Could not parse your time. Try like the following' \
            "```!reminder 60s This is my reminder. It goes off in 60 seconds.```\n" \
            'Choose from (s)econds, (m)inutes, and (h)ours.'
          )
          return
        end

        username = event.author.username
        reminder = Reminder.new(username, time_to_play, msg.join(' '), event)
        @reminders.push(reminder)
        event.send_message("Saved your reminder: @#{username}. You will be reminded at #{time_to_play.strftime('%F %T')}")
      end

      # Send all reminders then discard them.
      def on_refresh
        removed = []
        @reminders.each do |r|
          if r.remind?
            r.remind
            removed.push(r)
          end
        end

        unless removed.empty?
          removed.each do |reminder|
            @reminders.delete(reminder)
          end
        end
      end
    end
  end
end
