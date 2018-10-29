require 'chillbud/plugins/hello'

RSpec.describe HelloPlugin do
  it 'can be initalized' do
    expect(Chillbud::Plugins::HelloPlugin).to_not be nil
  end
end
