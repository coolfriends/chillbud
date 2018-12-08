
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chillbud/version"

Gem::Specification.new do |spec|
  spec.name          = "chillbud"
  spec.version       = Chillbud::VERSION
  spec.authors       = ["Kyri Vanderpoel"]
  spec.email         = ["vanderpoel.kyriay@gmail.com"]
  spec.summary       = "Chillbud will answer commands in Discord"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["chillbud"]
  spec.require_paths = ["lib"]

  spec.add_dependency "discordrb"
  spec.add_dependency "roda"
  spec.add_dependency "sucker_punch"
  spec.add_dependency "puma"

  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-console"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
end
