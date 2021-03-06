# frozen_string_literal: true

require 'sucker_punch'
require_relative '../chillbud'
require_relative '../plugins/hello'

module Chillbud
  module Jobs
    class ChillbudJob
      include SuckerPunch::Job

      @buds = {}
      class << self
        attr_accessor :buds
      end

      def perform(data)
        action = data[:action]
        return start_bud(data) if action == :start

        stop_bud(data) if action == :stop
      end

      def start_bud(data)
        token = data[:discord_token]
        bud = Chillbud.new(token) do |c|
          c.plugin :hello
          c.plugin :reminder
        end
        ChillbudJob.buds[token] = bud
        puts "Starting bot with token: #{token}"
        bud.start
      end

      def stop_bud(data)
        token = data[:discord_token]
        puts "Stopping bot with token: #{token}"
        ChillbudJob.buds[token]&.stop
        ChillbudJob.buds[token] = nil
      end
    end
  end
end
