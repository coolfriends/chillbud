require 'spec_helper'
require 'time'
require 'chillbud/plugins/reminder'

RSpec.describe Chillbud::Plugins::ReminderPlugin::Reminder do
  Reminder = Chillbud::Plugins::ReminderPlugin::Reminder
  it 'can be initalized' do
    r = Reminder.new("kbougy", DateTime.new(2018, 11, 23, 5, 5, 5), "This is the reminder.", {})
    expect(r).to_not be nil
    expect(r.to_s).to eq("2018-11-23 05:05:05: This is the reminder. @kbougy")
  end
end

RSpec.describe Chillbud::Plugins::ReminderPlugin do
  context '#initalize' do
    p = Chillbud::Plugins::ReminderPlugin.new
    it 'can be initalized' do
      expect(p.command).to eq('reminder')
    end
  end

  context '#run' do
    p = Chillbud::Plugins::ReminderPlugin.new
    it 'adds a reminder' do
      event = double()
      allow(event).to receive(:content) { "!reminder 15s I'm a good boy" }

      author = double()
      allow(author).to receive(:username) { "kbougy" }
      allow(event).to receive(:author) { author }

      expect(event).to receive(:send_message).once
      p.run(event)
    end
  end
end
