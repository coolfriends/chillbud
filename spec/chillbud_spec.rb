RSpec.describe Chillbud do
  it "has a version number" do
    expect(Chillbud::VERSION).not_to be nil
  end

  it "can be configured with a block" do
    bud = Chillbud::Chillbud.new do |b|
      b.discord_token = "mytoken"
      b.prefix = "~"
    end
    expect(bud.discord_token).to eq("mytoken")
    expect(bud.prefix).to eq("~")
  end

end
