require 'spec_helper'
require 'chillbud/plugins/hello'

describe Chillbud::Plugins::HelloPlugin do
  it 'can be initalized' do
    expect(Chillbud::Plugins::HelloPlugin).to_not be nil
  end
end
