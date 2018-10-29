module Chillbud
  def self.include_all
    require 'chillbud/version'
    require 'chillbud/chillbud'
    require 'chillbud/plugins'
    require 'chillbud/plugins/hello'
  end
end
